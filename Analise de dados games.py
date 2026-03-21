import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
import matplotlib.pyplot as plt

# dados
df = pd.read_csv("games.csv")

# colunas numericas
df['critic_score'] = pd.to_numeric(df['critic_score'], errors='coerce')
df['total_sales'] = pd.to_numeric(df['total_sales'], errors='coerce')

# filtrar colunas nulas
df = df[['critic_score', 'release_year', 'genre', 'total_sales']].dropna()
df = pd.get_dummies(df, columns=['genre'], drop_first=True)

# separar os eixos
X = df.drop('total_sales', axis=1)
y = df['total_sales']

# treino/teste
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# modelo grafico
model = LinearRegression()
model.fit(X_train, y_train)

# previsao
y_pred = model.predict(X_test)

# valores 
print("MSE:", mean_squared_error(y_test, y_pred))
print("R²:", r2_score(y_test, y_pred))

# grafico
plt.figure(figsize=(8, 6))
plt.scatter(y_test, y_pred, alpha=0.7)
plt.xlabel("Vendas Reais")
plt.ylabel("Vendas Previstas")
plt.title("Previsão de Vendas de Jogos")
plt.grid(True)
plt.show()
