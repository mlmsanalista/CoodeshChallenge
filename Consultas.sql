/*
Listar todos Clientes que não tenham realizado uma compra;
Listar os Produtos que não tenham sido comprados
Listar os Produtos sem Estoque;
Agrupar a quantidade de vendas que uma determinada Marca por Loja.
Listar os Funcionarios que não estejam relacionados a um Pedido.
*/
--Listar todos Clientes que não tenham realizado uma compra;
SELECT C.*
  FROM CUSTOMERS AS C
  LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
 WHERE O.CUSTOMER_ID IS NULL

--Listar os Produtos que não tenham sido comprados
SELECT *
  FROM PRODUCTS P
  LEFT JOIN ORDER_ITEMS O ON O.PRODUCT_ID = P.PRODUCT_ID
 WHERE O.PRODUCT_ID IS NULL

--Listar os Produtos sem Estoque;
SELECT P.*
  FROM PRODUCTS P
  INNER JOIN STOCKS S ON S.PRODUCT_ID = P.PRODUCT_ID
 WHERE S.QUANTITY <= 0

--Agrupar a quantidade de vendas que uma determinada Marca por Loja.
SELECT B1.BRAND_NAME,S1.STORE_NAME,T1.ITEMS
  FROM (SELECT B.BRAND_ID,O1.STORE_ID,COUNT(O.PRODUCT_ID)[ITEMS]
		  FROM BRANDS B
		 INNER JOIN PRODUCTS P ON P.BRAND_ID = B.BRAND_ID
		 INNER JOIN ORDER_ITEMS O ON O.PRODUCT_ID = P.PRODUCT_ID
		 INNER JOIN ORDERS O1 ON O1.ORDER_ID = O.ORDER_ID
		GROUP BY B.BRAND_ID,O1.STORE_ID) AS T1
 LEFT JOIN BRANDS B1 ON B1.BRAND_ID = T1.BRAND_ID
 LEFT JOIN STORES S1 ON S1.STORE_ID = T1.STORE_ID
--Listar os Funcionarios que não estejam relacionados a um Pedido.
SELECT S.*
  FROM STAFFS S
  LEFT JOIN ORDERS O ON O.STAFF_ID = S.STAFF_ID
 WHERE O.STAFF_ID IS NULL
