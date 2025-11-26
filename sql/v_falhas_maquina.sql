SELECT
  m.nome_maquina,
  l.nome_linha,
  COUNTIF(p.tipo_parada = 'Não Planejada') AS qtd_falhas,
  SUM(
    IF(p.tipo_parada = 'Não Planejada', p.duracao_min, 0)
  ) AS tempo_total_falhas
FROM
  producao_manutencao_analytics.fato_parada AS p
JOIN
  producao_manutencao_analytics.dim_maquina AS m
ON
  p.id_maquina = m.id_maquina
JOIN
  producao_manutencao_analytics.dim_linha AS l
ON
  m.id_linha = l.id_linha
GROUP BY
  m.nome_maquina,
  l.nome_linha;