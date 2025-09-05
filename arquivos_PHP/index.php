<?php
echo "Ola Mundo!";
?>

#conect to the MySQL server
conn = mysql.connector.connect(
    host="localhost",
    user= "root",
    password= "senaisp",
    database= "Ffdp_fabricadeprodutos"
)
cursor = conn.cursor()

#run a query
cursor.execute("SELECT * FROM fdp_fabricadeprodutos")