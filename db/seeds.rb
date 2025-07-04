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
  }
]

sample_memos.each do |memo_data|
  memo = Memo.find_or_create_by!(title: memo_data[:title]) do |m|
    m.content = memo_data[:content]
    m.archived = false
  end

  memo_data[:tags].each do |tag_name|
    tag = Tag.find_by(name: tag_name)
    if tag && !memo.tags.include?(tag)
      memo.tags << tag
    end
  end
end
