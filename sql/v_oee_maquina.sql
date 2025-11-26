SELECT
  m.nome_maquina,
  l.nome_linha,
  p.id_data,
  SAFE_DIVIDE(
    p.tempo_operacao_min,
    (p.tempo_disponivel_min - p.tempo_paradas_planejadas_min)
  ) AS disponibilidade,
  SAFE_DIVIDE(
    (p.qtd_produzida * p.tempo_ciclo_ideal_seg) / 60,
    p.tempo_operacao_min
  ) AS performance,
  SAFE_DIVIDE(
    (p.qtd_produzida - p.qtd_refugo),
    p.qtd_produzida
  ) AS qualidade,
  SAFE_DIVIDE(
    p.tempo_operacao_min,
    (p.tempo_disponivel_min - p.tempo_paradas_planejadas_min)
  )
  * SAFE_DIVIDE(
      (p.qtd_produzida * p.tempo_ciclo_ideal_seg) / 60,
      p.tempo_operacao_min
    )
  * SAFE_DIVIDE(
      (p.qtd_produzida - p.qtd_refugo),
      p.qtd_produzida
    ) AS oee
FROM
  producao_manutencao_analytics.fato_producao AS p
JOIN
  producao_manutencao_analytics.dim_maquina AS m
ON
  p.id_maquina = m.id_maquina
JOIN
  producao_manutencao_analytics.dim_linha AS l
ON
  m.id_linha = l.id_linha;
