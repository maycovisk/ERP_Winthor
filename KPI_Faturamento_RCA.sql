 SELECT 'FATURAMENTO POR RCA' AS SERIE
 ,PCUSUARI.NOME AS X
 ,ROUND(NVL(VIEW_VENDAS_RESUMO_FATURAMENTO.VALOR,0),2) AS Y
 FROM
    (SELECT CODUSUR
    ,ROUND(SUM(VLVENDA),2) AS VALOR 
    FROM VIEW_VENDAS_RESUMO_FATURAMENTO
        WHERE TO_CHAR(DTSAIDA,'MM/YYYY') = TO_CHAR(SYSDATE,'MM/YYYY') 
            AND CODSUPERVISOR IN ('1','2','3')
            AND NVL(CONDVENDA, 0) NOT IN (4, 8, 10, 13, 20, 98, 99)
            AND CODUSUR NOT IN ('4','7', '32', '34', '94')
            AND NVL(CODFISCAL,0) NOT IN (522,622,722,532,632,732) 
    GROUP BY CODUSUR
)VIEW_VENDAS_RESUMO_FATURAMENTO ,PCUSUARI
    WHERE PCUSUARI.CODUSUR = VIEW_VENDAS_RESUMO_FATURAMENTO.CODUSUR
    ORDER BY 3 DESC 
