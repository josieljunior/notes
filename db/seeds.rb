# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Criando tags predefinidas
tags = [
  "Trabalho",
  "Pessoal",
  "Importante",
  "Urgente",
  "Projeto",
  "Ideia",
  "Reunião",
  "Rarefa",
  "Estudo",
  "Lembrete",
  "Compras",
  "Saúde",
  "Família",
  "Financeiro",
  "Viagem"
]

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name.downcase.strip) do |tag|
    tag.name = tag_name
  end
end

sample_memos = [
  {
    title: "Reunião de planejamento Q1 2025",
    content: "Pontos a discutir:\n- Metas para o primeiro trimestre\n- Orçamento aprovado\n- Novos projetos prioritários\n- Revisão da equipe\n\nData: Segunda-feira, 9h\nLocal: Sala de reuniões 3",
    tags: [ "Trabalho", "Reunião", "Importante" ]
  },
  {
    title: "Lista de compras da semana",
    content: "Supermercado:\n- Arroz\n- Feijão\n- Carne para churrasco\n- Verduras (alface, tomate, cebola)\n- Frutas (banana, maçã, laranja)\n- Leite\n- Ovos\n- Pão\n\nFarmácia:\n- Vitamina C\n- Protetor solar",
    tags: [ "Pessoal", "Compras", "Lembrete" ]
  },
  {
    title: "Ideias para projeto mobile",
    content: "Funcionalidades principais:\n1. Sistema de login com biometria\n2. Dashboard personalizado\n3. Notificações push inteligentes\n4. Modo offline\n5. Sincronização em tempo real\n\nTecnologias:\n- React Native\n- Firebase\n- Redux Toolkit\n- TypeScript",
    tags: [ "Trabalho", "Projeto", "Ideia" ]
  },
  {
    title: "Estudos para certificação",
    content: "Cronograma de estudos:\n\nSemana 1-2: Fundamentos\n- Revisar conceitos básicos\n- Fazer exercícios práticos\n\nSemana 3-4: Tópicos avançados\n- Estudar casos de uso complexos\n- Simulados\n\nSemana 5: Revisão final\n- Mock exams\n- Revisão de pontos fracos\n\nData do exame: 15 de março",
    tags: [ "Estudo", "Importante", "Pessoal" ]
  },
  {
    title: "Consulta médica - checkup anual",
    content: "Data: 20 de janeiro, 14h30\nDr. Silva - Clínica Vida Saudável\nRua das Flores, 123\n\nExames solicitados:\n- Hemograma completo\n- Colesterol\n- Glicemia\n- Vitamina D\n\nLevar:\n- Carteirinha do convênio\n- RG\n- Exames anteriores",
    tags: [ "Saúde", "Importante", "Lembrete" ]
  },
  {
    title: "Planejamento financeiro 2025",
    content: "Metas financeiras:\n\n💰 Emergência: R$ 30.000 (6 meses de gastos)\n🏠 Casa própria: R$ 50.000 entrada\n✈️ Viagem Europa: R$ 15.000\n📚 Cursos: R$ 5.000\n\nInvestimentos:\n- 60% Renda fixa\n- 30% Ações\n- 10% Fundos imobiliários\n\nRevisão mensal: todo dia 5",
    tags: [ "Financeiro", "Importante", "Pessoal" ]
  },
  {
    title: "Receita - Bolo de chocolate da vovó",
    content: "Ingredientes:\n- 3 ovos\n- 2 xícaras de açúcar\n- 1 xícara de óleo\n- 1 xícara de leite\n- 3 xícaras de farinha\n- 1 xícara de chocolate em pó\n- 1 colher de fermento\n\nModo de preparo:\n1. Bater ovos com açúcar\n2. Adicionar óleo e leite\n3. Misturar farinha, chocolate e fermento\n4. Assar 180°C por 40 min\n\nCobertura: ganache com creme de leite",
    tags: [ "Pessoal", "Família" ]
  },
  {
    title: "Roteiro viagem - Rio de Janeiro",
    content: "Dia 1: Chegada\n- Check-in hotel Copacabana\n- Almoço na praia\n- Cristo Redentor (tarde)\n\nDia 2: Centro histórico\n- Santa Teresa\n- Lapa (Escadaria Selarón)\n- Teatro Municipal\n\nDia 3: Zona Sul\n- Pão de Açúcar\n- Praia de Ipanema\n- Lagoa Rodrigo de Freitas\n\nDia 4: Tijuca\n- Floresta da Tijuca\n- Cachoeira\n- Mirante da Vista Chinesa",
    tags: [ "Viagem", "Pessoal", "Lembrete" ]
  },
  {
    title: "Planejamento de férias",
    content: "Definir destinos, orçamento e datas disponíveis para as férias de 2025.",
    tags: [ "Viagem", "Pessoal" ]
  },
  {
    title: "Revisão de metas trimestrais",
    content: "Avaliar o progresso das metas estabelecidas para o trimestre e ajustar conforme necessário.",
    tags: [ "Trabalho", "Importante" ]
  },
  {
    title: "Lista de tarefas domésticas",
    content: "- Limpar a casa\n- Lavar roupas\n- Organizar armários\n- Comprar mantimentos",
    tags: [ "Pessoal", "Lembrete" ]
  },
  {
    title: "Ideias para novo projeto",
    content: "Brainstorm de funcionalidades e tecnologias para o próximo projeto da equipe.",
    tags: [ "Trabalho", "Projeto" ]
  },
  {
    title: "Consulta odontológica",
    content: "Data: 15 de julho, 10h\nLocal: Clínica Sorriso\nLevar: Carteirinha do convênio e exames anteriores.",
    tags: [ "Saúde", "Importante" ]
  },
  {
    title: "Planejamento de evento corporativo",
    content: "Organizar cronograma, lista de convidados e fornecedores para o evento anual da empresa.",
    tags: [ "Trabalho", "Reunião" ]
  },
  {
    title: "Estudo de caso para certificação",
    content: "Analisar e resolver o estudo de caso proposto no material da certificação.",
    tags: [ "Estudo", "Importante" ]
  },
  {
    title: "Receita de torta de maçã",
    content: "Ingredientes:\n- Maçãs\n- Açúcar\n- Canela\n- Massa folhada\nModo de preparo:\n1. Cortar as maçãs\n2. Misturar com açúcar e canela\n3. Colocar na massa folhada\n4. Assar por 30 minutos.",
    tags: [ "Pessoal", "Família" ]
  },
  {
    title: "Roteiro para viagem internacional",
    content: "Definir itinerário, reservas e documentos necessários para a viagem ao exterior.",
    tags: [ "Viagem", "Importante" ]
  },
  {
    title: "Revisão de orçamento pessoal",
    content: "Analisar despesas e receitas do mês para ajustar o planejamento financeiro.",
    tags: [ "Financeiro", "Pessoal" ]
  },
  {
    title: "Checklist para reunião semanal",
    content: "Preparar agenda, revisar tópicos pendentes e enviar convites para a reunião semanal.",
    tags: [ "Trabalho", "Reunião" ]
  },
  {
    title: "Planejamento de atividades do fim de semana",
    content: "Organizar passeios, compras e tarefas domésticas para o próximo fim de semana.",
    tags: [ "Pessoal", "Lembrete" ]
  },
  {
    title: "Estudo sobre novas tecnologias",
    content: "Pesquisar e aprender sobre as últimas tendências em desenvolvimento de software.",
    tags: [ "Estudo", "Projeto" ]
  },
  {
    title: "Consulta com nutricionista",
    content: "Data: 22 de julho, 15h\nLocal: Clínica Vida Saudável\nLevar: Diário alimentar e exames recentes.",
    tags: [ "Saúde", "Importante" ]
  },
  {
    title: "Planejamento de campanha publicitária",
    content: "Definir objetivos, público-alvo e estratégias para a nova campanha de marketing.",
    tags: [ "Trabalho", "Projeto" ]
  },
  {
    title: "Revisão de contratos",
    content: "Analisar cláusulas e condições dos contratos antes de enviar para aprovação.",
    tags: [ "Trabalho", "Importante" ]
  },
  {
    title: "Receita de pão caseiro",
    content: "Ingredientes:\n- Farinha\n- Água\n- Fermento\n- Sal\nModo de preparo:\n1. Misturar os ingredientes\n2. Deixar crescer por 1 hora\n3. Assar por 40 minutos.",
    tags: [ "Pessoal", "Família" ]
  },
  {
    title: "Roteiro para viagem de negócios",
    content: "Organizar reuniões, visitas e eventos para a viagem de negócios.",
    tags: [ "Viagem", "Trabalho" ]
  },
  {
    title: "Revisão de despesas corporativas",
    content: "Analisar relatórios financeiros e identificar oportunidades de redução de custos.",
    tags: [ "Financeiro", "Trabalho" ]
  },
  {
    title: "Planejamento de treinamento técnico",
    content: "Definir cronograma, materiais e objetivos para o treinamento da equipe técnica.",
    tags: [ "Trabalho", "Estudo" ]
  },
  {
    title: "Planejamento de metas anuais",
    content: "Definir objetivos e estratégias para alcançar as metas estabelecidas para o ano.",
    tags: [ "Trabalho", "Importante" ]
  },
  {
    title: "Lista de compras para festa",
    content: "Comprar bebidas, salgados, doces e decoração para a festa de aniversário.",
    tags: [ "Pessoal", "Lembrete" ]
  },
  {
    title: "Estudo sobre inteligência artificial",
    content: "Pesquisar e aprender sobre os avanços recentes em IA e suas aplicações.",
    tags: [ "Estudo", "Projeto" ]
  },
  {
    title: "Consulta oftalmológica",
    content: "Data: 30 de julho, 10h\nLocal: Clínica Visão Perfeita\nLevar: Exames anteriores e óculos.",
    tags: [ "Saúde", "Importante" ]
  },
  {
    title: "Planejamento de lançamento de produto",
    content: "Definir cronograma, estratégias de marketing e público-alvo para o novo produto.",
    tags: [ "Trabalho", "Projeto" ]
  },
  {
    title: "Revisão de políticas internas",
    content: "Analisar e atualizar as políticas internas da empresa conforme as novas regulamentações.",
    tags: [ "Trabalho", "Importante" ]
  },
  {
    title: "Receita de lasanha caseira",
    content: "Ingredientes:\n- Massa de lasanha\n- Molho de tomate\n- Carne moída\n- Queijo\nModo de preparo:\n1. Preparar o molho\n2. Montar a lasanha\n3. Assar por 40 minutos.",
    tags: [ "Pessoal", "Família" ]
  },
  {
    title: "Roteiro para viagem de férias",
    content: "Organizar passeios, reservas e atividades para as férias de verão.",
    tags: [ "Viagem", "Pessoal" ]
  },
  {
    title: "Revisão de investimentos",
    content: "Analisar portfólio de investimentos e ajustar conforme os objetivos financeiros.",
    tags: [ "Financeiro", "Trabalho" ]
  },
  {
    title: "Planejamento de workshop técnico",
    content: "Definir cronograma, materiais e objetivos para o workshop de capacitação técnica.",
    tags: [ "Trabalho", "Estudo" ]
  }
]

# Archived memos
sample_memos += [
  {
    title: "Relatório de desempenho arquivado",
    content: "Análise detalhada do desempenho da equipe no último trimestre.",
    tags: [ "Trabalho", "Importante" ],
    archived: true
  },
  {
    title: "Lista de compras arquivada",
    content: "Itens para compra futura: arroz, feijão, leite, ovos.",
    tags: [ "Pessoal", "Lembrete" ],
    archived: true
  },
  {
    title: "Estudo sobre tecnologias arquivado",
    content: "Pesquisa sobre novas tecnologias para projetos futuros.",
    tags: [ "Estudo", "Projeto" ],
    archived: true
  },
  {
    title: "Consulta médica arquivada",
    content: "Data: 15 de agosto, 14h\nLocal: Clínica Saúde\nLevar: Exames anteriores.",
    tags: [ "Saúde", "Importante" ],
    archived: true
  },
  {
    title: "Planejamento de evento arquivado",
    content: "Detalhes do evento corporativo arquivado para referência futura.",
    tags: [ "Trabalho", "Reunião" ],
    archived: true
  },
  {
    title: "Revisão de contratos arquivada",
    content: "Contratos revisados e arquivados para consulta futura.",
    tags: [ "Trabalho", "Importante" ],
    archived: true
  },
  {
    title: "Receita de bolo arquivada",
    content: "Ingredientes:\n- Farinha\n- Açúcar\n- Ovos\nModo de preparo:\n1. Misturar\n2. Assar.",
    tags: [ "Pessoal", "Família" ],
    archived: true
  },
  {
    title: "Roteiro de viagem arquivado",
    content: "Planejamento de viagem arquivado para consulta futura.",
    tags: [ "Viagem", "Pessoal" ],
    archived: true
  },
  {
    title: "Revisão de investimentos arquivada",
    content: "Portfólio de investimentos arquivado para análise futura.",
    tags: [ "Financeiro", "Trabalho" ],
    archived: true
  },
  {
    title: "Planejamento de workshop arquivado",
    content: "Detalhes do workshop arquivado para referência futura.",
    tags: [ "Trabalho", "Estudo" ],
    archived: true
  },
  {
    title: "Metas anuais arquivadas",
    content: "Objetivos e estratégias arquivados para consulta futura.",
    tags: [ "Trabalho", "Importante" ],
    archived: true
  },
  {
    title: "Lista de compras para festa arquivada",
    content: "Itens para festa arquivados para referência futura.",
    tags: [ "Pessoal", "Lembrete" ],
    archived: true
  },
  {
    title: "Estudo sobre IA arquivado",
    content: "Pesquisa sobre inteligência artificial arquivada.",
    tags: [ "Estudo", "Projeto" ],
    archived: true
  },
  {
    title: "Consulta oftalmológica arquivada",
    content: "Detalhes da consulta arquivados para referência futura.",
    tags: [ "Saúde", "Importante" ],
    archived: true
  },
  {
    title: "Lançamento de produto arquivado",
    content: "Planejamento de lançamento arquivado para consulta futura.",
    tags: [ "Trabalho", "Projeto" ],
    archived: true
  },
  {
    title: "Políticas internas arquivadas",
    content: "Revisão de políticas arquivadas para consulta futura.",
    tags: [ "Trabalho", "Importante" ],
    archived: true
  },
  {
    title: "Receita de lasanha arquivada",
    content: "Ingredientes:\n- Massa\n- Molho\nModo de preparo:\n1. Preparar\n2. Assar.",
    tags: [ "Pessoal", "Família" ],
    archived: true
  },
  {
    title: "Roteiro de férias arquivado",
    content: "Planejamento de férias arquivado para consulta futura.",
    tags: [ "Viagem", "Pessoal" ],
    archived: true
  },
  {
    title: "Investimentos arquivados",
    content: "Detalhes de investimentos arquivados para análise futura.",
    tags: [ "Financeiro", "Trabalho" ],
    archived: true
  },
  {
    title: "Workshop técnico arquivado",
    content: "Planejamento de workshop arquivado para consulta futura.",
    tags: [ "Trabalho", "Estudo" ],
    archived: true
  }
]

(sample_memos).each do |memo_data|
  memo = Memo.find_or_create_by!(title: memo_data[:title]) do |m|
    m.content = memo_data[:content]
    m.archived = memo_data[:archived] || false
  end

  memo_data[:tags].each do |tag_name|
    tag = Tag.find_by(name: tag_name)
    if tag && !memo.tags.include?(tag)
      memo.tags << tag
    end
  end
end
