import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#import seaborn as sns
import yfinance as yf
import sys



def compute_value_open_for_date(portfolio,df,date):
    portfolio_value=0
    columns=list(portfolio.columns)
    columns.remove('cash')
    for comp in columns:
        portfolio_value += portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==date),['Open']].mean().values[0]
    return portfolio_value+portfolio.loc['number','cash']


def compute_weights_for_date(portfolio,df, date):
    portfolio_value=compute_value_open_for_date(portfolio,df,date)
    columns=list(portfolio.columns)
    columns.remove('cash')
    for comp in columns:
        portfolio.loc['weight',comp]=portfolio.loc['number',comp]*df.loc[(df['Date']==date) & (df['Stock_name']==comp),['Open']].mean().values[0]/portfolio_value 
    return portfolio


def compute_returns_portfolio(portfolio, df, date):
    portfolio_return=0
    columns=list(portfolio.columns)
    columns.remove('cash')
    for comp in columns:
        portfolio_return += portfolio.loc['weight',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==date),['returns']].mean().values[0]
    return portfolio_return

def compute_returns_portfolio_for_history_from_weights(portfolio,df):
    X=pd.DataFrame(np.zeros((len(set(df['Date'].values)),1)), columns=['R_M'],index=sorted(list(set(df['Date'].values))))
    print("X first 5 lines", X.head(5))
    for dates in X.index:
        X.loc[dates,'R_M']=compute_returns_portfolio(portfolio,df,dates)
    return X


def compute_returns_portfolio_for_history_from_number(portfolio,df):
    X=pd.DataFrame(np.zeros((len(set(df['Date'].values)),1)), columns=['R_M'],index=sorted(list(set(df['Date'].values))))
    for dates in X.index:
        compute_weights_for_date(portfolio,df,dates)
        X.loc[dates,'R_M']=compute_returns_portfolio(portfolio,df,dates)
    return X


def compute_returns_portfolio_for_history_from_weights(portfolio,df):
    X=pd.DataFrame(np.zeros((len(set(df['Date'].values)),1)), columns=['R_M'],index=sorted(list(set(df['Date'].values))))
    for dates in X.index:
        X.loc[dates,'R_M']=compute_returns_portfolio(portfolio,df,dates)
    return X

def compute_numbers_from_weights(portfolio,df,date,initial_capital):
    companies=list(portfolio.columns)
    companies.remove('cash')
    portfolio.loc['number','cash']=0
    sum_sanity=0
    for comp in companies:
        price=df.loc[(df['Date']==date) & (df['Stock_name']==comp),['Open']].mean().values[0]
#        print ("Price ", price, "date", date, "stock", comp)
        if price > 0:        
            portion=np.max([0,(portfolio.loc['weight',comp]*initial_capital)/price])
            portfolio.loc['number',comp]=np.floor(portion) #buy a number of share
            portfolio.loc['number', 'cash']=portfolio.loc['number', 'cash']+(portion-np.floor(portion))*price
            print ("Should be zero in numbers 1", portfolio.loc['number',comp]*price+(portion-np.floor(portion))*price-portfolio.loc['weight',comp]*initial_capital)

            print ("Portion ", portion,"Number ", np.floor(portion),  "cash ", (portion-np.floor(portion))*price, "comp", comp, "date", date)
            #round(portfolio.loc['weight',comp]*initial_capital/price)
            sum_sanity += portfolio.loc['number',comp]*price
        else:
            print ("Price is zero ", price)
    
    print ("Should be zero in numbers", sum_sanity+portfolio.loc['number','cash']-initial_capital)
    return portfolio

def compute_value_history_from_weights(portfolio,df,initial_capital):
    print ("X coumns", list(portfolio.columns)+['value'])
    X=pd.DataFrame(np.zeros((len(set(df['Date'].values)),len(portfolio.columns)+1)), columns=list(portfolio.columns)+['value'],index=sorted(list(set(df['Date'].values))))
    #compute_numbers_from_weights(portfolio,df,initial_capital)
    #compute_value_open_for_date(portfolio,df,dates)
    #X.loc[dates,'value']=portfolio_value
    #compute_weights_for_date(portfolio,df,dates)
    Dates_ordered=sorted(list(set(df['Date'].values)))
    #print ("Dates ordered", Dates_ordered)
    portfolio_value=initial_capital
    for dates in Dates_ordered:
        compute_numbers_from_weights(portfolio,df,dates,portfolio_value)
        #print ("Portfolio", str(portfolio)+" for date "+str(dates))
        portfolio_value=0
        columns=list(portfolio.columns)
        columns.remove('cash')
        for comp in columns:
            X.loc[dates,comp]=portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Close'].mean()
            #print ("X loc", X.loc[dates,comp])
            portfolio_value+=X.loc[dates,comp]   
        #print ("Portfolio value", str(portfolio_value)+" for date "+ str(dates))  
        portfolio_value += portfolio.loc['number', 'cash']
        X.loc[dates,'value']=portfolio_value
    return X


def compute_transaction_history_from_weights(portfolio,df,initial_capital):
    print ("X coumns", list(portfolio.columns)+['value'])
    X=pd.DataFrame(np.zeros((len(set(df['Date'].values)),
                             len(portfolio.columns)+1)), \
        columns=list(portfolio.columns)+['value'],\
        index=sorted(list(set(df['Date'].values))))
    #compute_numbers_from_weights(portfolio,df,initial_capital)
    #compute_value_open_for_date(portfolio,df,dates)
    #X.loc[dates,'value']=portfolio_value
    #compute_weights_for_date(portfolio,df,dates)
    Dates_ordered=sorted(list(set(df['Date'].values)))
    #print ("Dates ordered", Dates_ordered)
    portfolio_value=initial_capital
    
    compute_numbers_from_weights(portfolio,df,Dates_ordered[0],portfolio_value)
    
    portfolio_value_old=portfolio_value
    portfolio_value=0
    sum_value_buy=0
    sum_value_sell=0
    sum_sanity=portfolio.loc['number','cash']
    columns=list(portfolio.columns)
    dates=Dates_ordered[0]
    columns.remove('cash')
    for comp in columns:
        X.loc[dates,comp]=portfolio.loc['number',comp]
         
        portfolio_value+=portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Close'].mean()
            
        if X.loc[dates,comp] > 0:
            sum_value_buy += X.loc[dates,comp]*\
            df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean()              
        else:
            sum_value_sell += -X.loc[dates,comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean() 

            sum_sanity += portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean() 
            
    X.loc[dates, 'cash'] = portfolio.loc['number','cash']
    portfolio_value += portfolio.loc['number','cash']
    print ("Portfolio value old", str(portfolio_value_old)+\
                " portfolio value new "+str(portfolio_value)+ " for date "+ str(dates))
    print ("New portfolio \n ", portfolio,\
                "\n value of sold shares ", sum_value_sell,\
               "value of bough shares", sum_value_buy,\
               "transactions \n ", X.loc[dates,:])
    print ("Sanity ", sum_sanity-portfolio_value_old)
               
    X.loc[dates,'value']=portfolio_value


    for i in range(1, len(Dates_ordered)):
        dates=Dates_ordered[i]
        old_portfolio=portfolio.copy()
        portfolio_value_old=compute_value_open_for_date(old_portfolio,df,dates)
        print ("Old portfolio values ", portfolio_value_old)
        sum_sanity = old_portfolio.loc['number','cash']
        compute_numbers_from_weights(portfolio,df,dates,portfolio_value_old)
        portfolio_value_sanity = compute_value_open_for_date(portfolio,df,dates)
        print ("Should be zero", portfolio_value_old-portfolio_value_sanity)

        #print ("Portfolio", str(portfolio)+" for date "+str(dates))
        old_portfolio_value=portfolio_value
        portfolio_value=0
        sum_value_buy=0
        sum_value_sell=0
        columns=list(portfolio.columns)
        columns.remove('cash')
        for comp in columns:
            X.loc[dates,comp]=portfolio.loc['number',comp]-\
                               old_portfolio.loc['number',comp]            
            portfolio_value+=portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Close'].mean()
            
            if X.loc[dates,comp] > 0:
                sum_value_buy += X.loc[dates,comp]*\
                 df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean()              
            else:
                sum_value_sell += -X.loc[dates,comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean() 

            sum_sanity += old_portfolio.loc['number',comp]*df.loc[(df['Stock_name']==comp) & (df['Date']==dates),'Open'].mean() 
            
        X.loc[dates, 'cash'] = portfolio.loc['number','cash']-\
                    old_portfolio.loc['number','cash']
        portfolio_value += portfolio.loc['number','cash']
        print ("Portfolio value old", str(portfolio_value_old)+\
                " portfolio value new "+str(portfolio_value)+ " for date "+ str(dates))
        print ("Old portfolio \n", old_portfolio,\
                "New portfolio \n ", portfolio,\
                "\n value of sold shares ", sum_value_sell,\
               "value of bough shares", sum_value_buy,\
               "transactions \n ", X.loc[dates,:])
        print ("Values sell + cash - sum_value_buy=0 ", -sum_value_sell+portfolio.loc['number', 'cash']-old_portfolio.loc['number', 'cash']+sum_value_buy)
        print ("Sanity ", sum_sanity-portfolio_value_old)
               
        X.loc[dates,'value']=portfolio_value
    return X

#Find beta_i, alpha_i
def find_alpha_beta(portfolio,df,benchmark_portfolio):
    from sklearn.linear_model import LinearRegression
    lr=LinearRegression()
    X=compute_returns_portfolio_for_history_from_weights(benchmark_portfolio,df)

    #X=Xp[list(Companies)]
    
    #print ("X first 5 lines", X.head(5))

    for comp in Companies: 
        DD=df.loc[df['Stock_name']==comp,:]
        Y=pd.DataFrame(np.zeros((len(set(DD['Date'].values)),1)),columns=['R_i'],index=sorted(list(set(DD['Date'].values))))
        for dates in df.loc[df['Stock_name']==comp,'Date'].values:
            #print ("dates", dates)
            #print ("X info: "+str(X.index)+", columns: "+str(X.columns)+ "info: "+str(X.info())+ " first 5 rows: "+str(X.head(5)))
            #print ("X row ", X.loc[dates,'R_M'])
            #print ("DD", DD.loc[DD['Date']==dates,['returns']].mean())
            #compute_weights_for_date(benchmark_portfolio,df,dates)
            #compute_returns_portfolio(benchmark_portfolio,df,dates)
            #X.loc[dates,'R_M']=
            Y.loc[dates,'R_i']=DD.loc[(DD['Date']==dates) & (df['Stock_name']==comp),['returns']].mean().values[0]
        #print ("X first 5 lines", X.head(5))
        #print ("Y first 5 lines", Y.head(5))
        lr.fit(X,Y)
        portfolio.loc['alpha',comp]=lr.intercept_[0]
        portfolio.loc['beta',comp]=lr.coef_[0][0]
        #print ("Alpha for "+comp+" is: "+str(portfolio.loc['alpha',comp]))
        #print ("Beta for "+comp+" is: "+str(portfolio.loc['beta',comp]))
        from sklearn.metrics import mean_squared_error
        #print("Mean error "+comp + " ", mean_squared_error(lr.predict(X),Y))
        portfolio.loc['avg_error',comp]=np.mean(Y-lr.predict(X))
        #print ("Mean error "+comp+" ", np.mean(lr.predict(X)-Y))

def computer_stock_return_means_and_covariances(df):
    Companies=list(set(df['Stock_name'].values))
    #print ("Length of companies", len(Companies))
    Xcov=pd.DataFrame(np.zeros((len(Companies),len(Companies))), columns=Companies,index=Companies)
    Xmeans=pd.DataFrame(np.zeros((1,len(Companies))), columns=Companies,index=['mean'])
    for comp in Companies:
        Xmeans.loc['mean',comp]=df.loc[df['Stock_name']==comp,'returns'].mean()
        for comp1 in Companies:
            Xcov.loc[comp,comp1]=np.cov(df.loc[df['Stock_name']==comp,'returns'], df.loc[df['Stock_name']==comp1,'returns'])[0][1]
    
    #print ("Xmeans", Xmeans)
    #print ("Xcov", Xcov)
    return (Xmeans, Xcov)




def compute_optimal_weights_for_fixed_return(portfolio,df,benchmark_portfolio, target_return):
    find_alpha_beta(portfolio,df,benchmark_portfolio)
    import cvxpy as cp
    Xmeans, Xcov=computer_stock_return_means_and_covariances(df)
    #print ("Xmeans", Xmeans)
    #print ("Xcov", Xcov)
    
    A1=Xmeans.loc['mean',:].values
    columns=list(portfolio.columns)
    columns.remove('cash')
    A3=np.ones((1,len(columns)))
    x = cp.Variable(len(columns))
    Q=Xcov.values
    print("A1", A1)
    #print("A1 shape", A1.shape)
    #print ("Q", Q)
    constraints = [x >= 0, A3@x == 1, A1@x >= target_return]
    objective = cp.Minimize(x.T@ Q @x)

    prob = cp.Problem(objective, constraints)
    prob.solve()
    print("Constraints:", constraints)

    print("Optimal value:", prob.value)
    print("Optimal x:", x.value)
    print ("Constraints: sum==1:"+str(A3@x.value)+str("target return")+str(A1@x.value))
    print ("Risk: "+str(np.transpose(x.value)@ Q @x.value))

    for i  in range(len(columns)):
        portfolio.loc['weight',columns[i]]=x.value[i]
        #portfolio.loc['number',comp]=round(portfolio.loc['weight',comp]*compute_value_open_for_date(portfolio,df,date)/df.loc[df['Date']==date,'Open'].mean())
    beta=np.dot(portfolio.loc['beta',columns].values,x.value)
    alpha=np.dot(portfolio.loc['alpha',columns].values,x.value)
    return (prob.value,alpha,beta) #risk of the portfolio



def compute_optimal_weights(portfolio,df,benchmark_portfolio, beta_target):
    find_alpha_beta(portfolio,df,benchmark_portfolio)
    epsilon=0.001   

    import cvxpy as cp

    columns=list(portfolio.columns)
    columns.remove('cash')
    A1=np.array([list(portfolio.loc['beta',columns].values),\
                list(-portfolio.loc['beta',columns].values)])
    A2=np.eye(len(columns))  
    A3=np.ones((1,len(columns))) 
    A4=-np.ones((1,len(columns)))
    b1=np.array([[beta_target]])
    b2=np.array([[-beta_target]])
    b3=np.ones((len(columns),1))
    b4=np.array([[1]])
    b4=-np.array([[1]])


    A=np.vstack((A1,A2,A3,A4))
    print ("A1 matrix",A1[0,:])
    print ("b1 shape",b1.shape)
    print ("b2 shape",b2.shape)
    print ("b3 shape",b3.shape)
    print ("b4 shape",b4.shape)
    b=np.vstack((b1,b2,b3,b4))
    print ("b",b)

    x = cp.Variable(len(columns))
    constraints = [x >= 0, A3@x == 1, A1[0,:]@x == b1]
    X=compute_returns_portfolio_for_history_from_weights(benchmark_portfolio,df)
    c=np.array([portfolio.loc['alpha',columns].values]) #+np.array([portfolio.loc['beta',:].values])*(X.mean().values[0])
    #print ("c",c)
    #print ("c shape",c.shape)
    #c=np.ones((1,len(portfolio.columns)))
    #for i in range(len(portfolio.columns)):
    #    c[0,i]=df.loc[df['Stock_name']==portfolio.columns[i],['returns']].mean().values[0]
    print("c",c)
    objective = cp.Minimize(-c@x)

    prob = cp.Problem(objective, constraints)
    prob.solve()
    print("Constraints:", constraints)

    print("Optimal value:", prob.value)
    print("Optimal x:", x.value)
    print ("Constraints: sum==1:"+str(A3@x.value)+str("target beta")+str(A1[0,:]@x.value))
    print ("Return: "+str(c@x.value))

    for i  in range(len(columns)):
        portfolio.loc['weight',portfolio.columns[i]]=x.value[i]
        #portfolio.loc['number',comp]=round(portfolio.loc['weight',comp]*compute_value_open_for_date(portfolio,df,date)/df.loc[df['Date']==date,'Open'].mean())
    return c@x.value

try:
    df=pd.read_csv('tech_companies_stock_prices.csv')
except FileNotFoundError:
    print ("File not found. Please make sure the file is in the same directory as this script.")
    sys.exit()


#def compute_variance (portfolio,df):
#    portfolio_value=0
#    for comp in portfolio.columns:
#        portfolio_value += portfolio.loc['number',comp]*df.loc[df['Date']==date,['Open']].mean().values[0]
#    return portfolio_value

print (df.head(10))

Companies=set(df['Stock_name'].values)
print (Companies)

#Portfolio
initial_portfolio=pd.DataFrame(columns=list(Companies)+['cash'],index=['alpha','beta','number','weight', 'avg_error'])
for comp in Companies:
    initial_portfolio.loc['weight',comp]=1/len(Companies)

initial_portfolio.loc['number', 'cash']=0
    
print ('Init port \n', initial_portfolio.head(1))

benchmark_portfolio=pd.DataFrame(columns=list(Companies)+['cash'],index=['alpha','beta','number','weight','avg_error'])
for comp in Companies:
    benchmark_portfolio.loc['weight',comp]=1/len(Companies)
    benchmark_portfolio.loc['number',comp]=0

benchmark_portfolio.loc['number', 'cash']=0
#benchmark_portfolio.loc['number','GOOGL']=10
#benchmark_portfolio.loc['number','META']=10

#benchmark_portfolio.loc['weight','META']=0.5
#benchmark_portfolio.loc['weight','GOOGL']=0.5



df['returns'] = (df['Close']-df['Open'])/df['Open']
Dates=set(df['Date'].values)

alternative_portfolio=initial_portfolio.copy()

print ("Beta")
beta_portfolio=0.7
alpha_portfolio=compute_optimal_weights(initial_portfolio,df,benchmark_portfolio,beta_portfolio)


print ("initial portfolio \n", initial_portfolio.head(5))

XX=compute_returns_portfolio_for_history_from_weights(initial_portfolio,df)
XXm=compute_returns_portfolio_for_history_from_weights(benchmark_portfolio,df)

#print ("XX", XX['R_M'].head(5))
print ("Average return of the porftolio", XX['R_M'].mean())
print ("Average return of the benchmark portfolio", XXm['R_M'].mean())
print ("Average return according to formula", alpha_portfolio+beta_portfolio*XXm['R_M'].mean()+\
     np.dot(initial_portfolio.loc['weight', :],initial_portfolio.loc['avg_error',:]))
print ("Volatility of the portfolio", XX['R_M'].std())
print ("Volatility of the benchmark portfolio", XXm['R_M'].std())
plt.plot(XX.index,XX['R_M'])
plt.plot(XX.index,XXm['R_M'])
plt.title('Portfolio returns')
plt.xlabel('Date')
plt.ylabel('Returns')
plt.legend(['Portfolio', 'Benchmark portfolio'])
initial_capital=300000
ZZ=compute_value_history_from_weights(initial_portfolio,df,initial_capital)
plt.figure()
plt.title('Portfolio value')
plt.xlabel('Date')
plt.plot(ZZ.index,ZZ['value'], label='Portfolio')
print ("Final portfolio value",ZZ['value'].iloc[-1])
print ("Average last 30 portfolio value",ZZ['value'].iloc[ZZ.shape[0]-30:ZZ.shape[0]].mean())
ZZm=compute_value_history_from_weights(benchmark_portfolio,df,initial_capital)
plt.plot(ZZm.index,ZZm['value'], label='Benchmark portfolio')
plt.legend(['Portfolio', 'Benchmark portfolio'])
print("Final benchmark portfolio value",ZZm['value'].iloc[-1])
print ("Average last 30 benchmark portfolio value",ZZm['value'].iloc[ZZm.shape[0]-30:ZZm.shape[0]].mean())


#Minimizing risk with target return

target_return=-0.002
risk,alpha,beta=compute_optimal_weights_for_fixed_return(alternative_portfolio,df,benchmark_portfolio,target_return)
print ("Risk of the portfolio", np.sqrt(risk))
print ("Alpha of the portfolio", alpha)
print ("Beta of the portfolio", beta)


print ("initial portfolio", alternative_portfolio.head(5))

XX=compute_returns_portfolio_for_history_from_weights(alternative_portfolio,df)
print ("Average return of the porftolio", XX['R_M'].mean())
print ("Average return of the benchmark portfolio", XXm['R_M'].mean())
print ("Average return according to formula", alpha_portfolio+beta_portfolio*XXm['R_M'].mean()+\
     np.dot(initial_portfolio.loc['weight', :],initial_portfolio.loc['avg_error',:]))
print ("Volatility of the portfolio", XX['R_M'].std())
print ("Volatility of the benchmark portfolio", XXm['R_M'].std())
plt.figure()
plt.title('Returns min. risk')
plt.plot(XX.index,XX['R_M'])
plt.plot(XX.index,XXm['R_M'])
plt.title('Portfolio returns')
plt.xlabel('Date')
plt.ylabel('Returns')
plt.legend(['Portfolio', 'Benchmark portfolio'])
ZZ=compute_value_history_from_weights(alternative_portfolio,df,initial_capital)
plt.figure()
plt.title('Portfolio value')
plt.xlabel('Date')
plt.plot(ZZ.index,ZZ['value'], label='Portfolio')
print ("Final portfolio value",ZZ['value'].iloc[-1])
print ("Average last 30 portfolio value",ZZ['value'].iloc[ZZ.shape[0]-30:ZZ.shape[0]].mean())
ZZm=compute_value_history_from_weights(benchmark_portfolio,df,initial_capital)
plt.plot(ZZm.index,ZZm['value'], label='Benchmark portfolio')
plt.legend(['Portfolio', 'Benchmark portfolio'])
print("Final benchmark portfolio value",ZZm['value'].iloc[-1])
print ("Average last 30 benchmark portfolio value",ZZm['value'].iloc[ZZm.shape[0]-30:ZZm.shape[0]].mean())

XXz=compute_transaction_history_from_weights(alternative_portfolio,df,initial_capital)

XXz.to_csv('test_portfolio.csv')

print ("Alpha portfolio \n")
print (initial_portfolio)
XXzz=compute_transaction_history_from_weights(initial_portfolio,df,initial_capital)

sys.exit(-1)


#plt.show()

