from difflib import SequenceMatcher

# File paths
file1_path = "students.txt"
file2_path = "students_list_assigned_groups.txt"

# Read names/surnames from the files, normalize to lowercase, handle extra spaces/tabs,
# and treat names/surnames with reversed order as the same
def normalize_name(name):
    parts = sorted(" ".join(name.split()).lower().split())
    return " ".join(parts)

def are_similar(name1, name2, max_diff=2):
    # Compute the edit distance-like similarity
    return SequenceMatcher(None, name1, name2).ratio() >= (1 - max_diff / max(len(name1), len(name2)))

def find_similar_names(names1, names2, max_diff=2):
    unmatched = set(names1)
    similar_pairs = {}
    for name1 in names1:
        for name2 in names2:
            if are_similar(name1, name2, max_diff):
                similar_pairs.setdefault(name1, []).append(name2)
                unmatched.discard(name1)
    return unmatched, similar_pairs

with open(file1_path, 'r') as file1:
    names1 = set(normalize_name(line) for line in file1)

with open(file2_path, 'r') as file2:
    names2 = set(normalize_name(line) for line in file2)

# Find differences and similar names
unmatched_in_file1, similar_in_file1 = find_similar_names(names1, names2)
unmatched_in_file2, similar_in_file2 = find_similar_names(names2, names1)

# Write results to output files
with open("in_file2_not_in_file1.txt", 'w') as out1:
    for name in unmatched_in_file2:
        out1.write(f"{name} (similar to: {', '.join(similar_in_file2.get(name, []))})\n")

with open("in_file1_not_in_file2.txt", 'w') as out2:
    for name in unmatched_in_file1:
        out2.write(f"{name} (similar to: {', '.join(similar_in_file1.get(name, []))})\n")
