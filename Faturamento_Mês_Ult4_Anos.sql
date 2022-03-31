SELECT TO_CHAR(SYSDATE, 'YYYY')-0 AS SERIE
,DATA AS X, ROUND(VENDA-DEVOL,2) AS Y 
FROM
    (SELECT VIEW_VENDAS_RESUMO_FATURAMENTO.DATA AS DATA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD AS DATADEV
    ,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR AS VENDA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV AS DEVOL
    FROM
        ((SELECT TRIM(TO_CHAR(LEVEL, '09')) AS DATA 
        FROM DUAL CONNECT BY LEVEL <=12))M,
            (SELECT TO_CHAR(DTSAIDA,'MM') AS DATA
            ,ROUND(SUM(VLVENDA),2) AS VALOR 
            FROM VIEW_VENDAS_RESUMO_FATURAMENTO
            WHERE TO_CHAR(DTSAIDA,'YYYY') = TO_CHAR(SYSDATE,'YYYY')   
            AND NVL(CONDVENDA, 0) NOT IN (4, 8, 10, 13, 20, 98, 99)
            AND NVL(CODFISCAL, 0) NOT IN (522, 622, 722, 532, 632, 732)
            GROUP BY TO_CHAR(DTSAIDA,'MM') ORDER BY DATA
            ) VIEW_VENDAS_RESUMO_FATURAMENTO,
        (SELECT TO_CHAR(DTENT,'MM') AS DATAD
        ,ROUND(SUM(NVL(VLDEVOLUCAO,0)),2) AS DEV 
        FROM VIEW_DEVOL_RESUMO_FATURAMENTO
        WHERE TO_CHAR(DTENT,'YYYY') = TO_CHAR(SYSDATE,'YYYY')
        AND NVL(CONDVENDA, 0) NOT IN (4, 10, 13, 20, 98, 99)
        GROUP BY TO_CHAR(DTENT,'MM') ORDER BY DATAD
        ) VIEW_DEVOL_RESUMO_FATURAMENTO
    WHERE 1=1
    AND VIEW_VENDAS_RESUMO_FATURAMENTO.DATA = VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
    AND M.DATA = VIEW_VENDAS_RESUMO_FATURAMENTO.DATA (+)
    GROUP BY VIEW_VENDAS_RESUMO_FATURAMENTO.DATA 
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
    ,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR 
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV)

UNION

SELECT TO_CHAR(SYSDATE, 'YYYY')-1 AS SERIE
,DATA AS X, ROUND(VENDA-DEVOL,2) AS Y 
FROM
    (SELECT VIEW_VENDAS_RESUMO_FATURAMENTO.DATA AS DATA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD AS DATADEV
    ,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR AS VENDA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV AS DEVOL
    FROM
        ((SELECT TRIM(TO_CHAR(LEVEL, '09')) AS DATA 
        FROM DUAL CONNECT BY LEVEL <=12))M,
            (SELECT TO_CHAR(DTSAIDA,'MM') AS DATA
            ,ROUND(SUM(VLVENDA),2) AS VALOR 
            FROM VIEW_VENDAS_RESUMO_FATURAMENTO
            WHERE TO_CHAR(DTSAIDA,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1   
            AND NVL(CONDVENDA, 0) NOT IN (4, 8, 10, 13, 20, 98, 99)
            AND NVL(CODFISCAL, 0) NOT IN (522, 622, 722, 532, 632, 732)
            GROUP BY TO_CHAR(DTSAIDA,'MM') ORDER BY DATA) VIEW_VENDAS_RESUMO_FATURAMENTO,
        (SELECT TO_CHAR(DTENT,'MM') AS DATAD
        ,ROUND(SUM(NVL(VLDEVOLUCAO,0)),2) AS DEV 
        FROM VIEW_DEVOL_RESUMO_FATURAMENTO
        WHERE TO_CHAR(DTENT,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1
        AND NVL(CONDVENDA, 0) NOT IN (4, 10, 13, 20, 98, 99)
        GROUP BY TO_CHAR(DTENT,'MM') ORDER BY DATAD) VIEW_DEVOL_RESUMO_FATURAMENTO
   WHERE 1=1
   AND VIEW_VENDAS_RESUMO_FATURAMENTO.DATA = VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
   AND M.DATA = VIEW_VENDAS_RESUMO_FATURAMENTO.DATA (+)
   GROUP BY VIEW_VENDAS_RESUMO_FATURAMENTO.DATA 
,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR 
,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV)

UNION

SELECT TO_CHAR(SYSDATE, 'YYYY')-2 AS SERIE
,DATA AS X, ROUND(VENDA-DEVOL,2) AS Y 
FROM
    (SELECT VIEW_VENDAS_RESUMO_FATURAMENTO.DATA AS DATA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD AS DATADEV 
    ,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR AS VENDA 
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV AS DEVOL
    FROM
        ((SELECT TRIM(TO_CHAR(LEVEL, '09')) AS DATA 
        FROM DUAL CONNECT BY LEVEL <=12))M,
            (SELECT TO_CHAR(DTSAIDA,'MM') AS DATA,ROUND(SUM(VLVENDA),2) AS VALOR FROM VIEW_VENDAS_RESUMO_FATURAMENTO
            WHERE TO_CHAR(DTSAIDA,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-2   
            AND NVL(CONDVENDA, 0) NOT IN (4, 8, 10, 13, 20, 98, 99)
            AND NVL(CODFISCAL, 0) NOT IN (522, 622, 722, 532, 632, 732)
            GROUP BY TO_CHAR(DTSAIDA,'MM') ORDER BY DATA) VIEW_VENDAS_RESUMO_FATURAMENTO,
        (SELECT TO_CHAR(DTENT,'MM') AS DATAD
        ,ROUND(SUM(NVL(VLDEVOLUCAO,0)),2) AS DEV 
        FROM VIEW_DEVOL_RESUMO_FATURAMENTO
        WHERE TO_CHAR(DTENT,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-2
        AND NVL(CONDVENDA, 0) NOT IN (4, 10, 13, 20, 98, 99)
        GROUP BY TO_CHAR(DTENT,'MM') ORDER BY DATAD) VIEW_DEVOL_RESUMO_FATURAMENTO
   WHERE 1=1
   AND VIEW_VENDAS_RESUMO_FATURAMENTO.DATA = VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
   AND M.DATA = VIEW_VENDAS_RESUMO_FATURAMENTO.DATA (+)
   GROUP BY VIEW_VENDAS_RESUMO_FATURAMENTO.DATA 
,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR
,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV)

UNION

SELECT TO_CHAR(SYSDATE, 'YYYY')-3 AS SERIE
,DATA AS X, ROUND(VENDA-DEVOL,2) AS Y 
FROM
    (SELECT VIEW_VENDAS_RESUMO_FATURAMENTO.DATA AS DATA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD AS DATADEV
    ,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR AS VENDA
    ,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV AS DEVOL
    FROM
        ((SELECT TRIM(TO_CHAR(LEVEL, '09')) AS DATA 
        FROM DUAL CONNECT BY LEVEL <=12))M,
            (SELECT TO_CHAR(DTSAIDA,'MM') AS DATA,ROUND(SUM(VLVENDA),2) AS VALOR FROM VIEW_VENDAS_RESUMO_FATURAMENTO
            WHERE TO_CHAR(DTSAIDA,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-3   
            AND NVL(CONDVENDA, 0) NOT IN (4, 8, 10, 13, 20, 98, 99)
            AND NVL(CODFISCAL, 0) NOT IN (522, 622, 722, 532, 632, 732)
            GROUP BY TO_CHAR(DTSAIDA,'MM') ORDER BY DATA) VIEW_VENDAS_RESUMO_FATURAMENTO,
        (SELECT TO_CHAR(DTENT,'MM') AS DATAD
        ,ROUND(SUM(NVL(VLDEVOLUCAO,0)),2) AS DEV FROM VIEW_DEVOL_RESUMO_FATURAMENTO
        WHERE TO_CHAR(DTENT,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-3
        AND NVL(CONDVENDA, 0) NOT IN (4, 10, 13, 20, 98, 99)
        GROUP BY TO_CHAR(DTENT,'MM') ORDER BY DATAD) VIEW_DEVOL_RESUMO_FATURAMENTO
   WHERE 1=1
   AND VIEW_VENDAS_RESUMO_FATURAMENTO.DATA = VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
   AND M.DATA = VIEW_VENDAS_RESUMO_FATURAMENTO.DATA (+)
   GROUP BY VIEW_VENDAS_RESUMO_FATURAMENTO.DATA 
,VIEW_DEVOL_RESUMO_FATURAMENTO.DATAD
,VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR 
,VIEW_DEVOL_RESUMO_FATURAMENTO.DEV)
ORDER BY 2
