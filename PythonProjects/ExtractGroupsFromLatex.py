import re

def extract_groups_and_students(latex_file_path):
    groups_and_students = {}

    # Regular expression to match group and student names
    group_pattern = r"Group\s+\d*"
    student_names_pattern = r"\((.*?)\)"

    with open(latex_file_path, 'r') as file:
        content = file.read()

        # Find all group sections
        group_matches = re.finditer(rf"({group_pattern})\s*{student_names_pattern}", content, flags=re.DOTALL)

        for match in group_matches:
            group_name = match.group(1)  # Extract group name
            student_names = match.group(2)  # Extract student names
            student_list = [name.strip() for name in student_names.split(',')]  # Split and clean names
            groups_and_students[group_name] = student_list

    return groups_and_students

# Example usage
if __name__ == "__main__":
    latex_file_path = "projectFall2025.tex"
    result = extract_groups_and_students(latex_file_path)
    for group, students in result.items():
        print(f"{group}: {', '.join(students)}")
    
    with open("students_list_assigned_groups.txt", "w") as output_file:
        all_students = sorted({student for students in result.values() for student in students})
        for student in all_students:
            output_file.write(student + "\n")
