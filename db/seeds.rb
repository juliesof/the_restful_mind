Quote.delete_all
QuoteList.delete_all


ql1 = QuoteList.create!(list_name: 'Literary Quotes')
ql2 = QuoteList.create!(list_name: 'Spiritual Quotes')

# Creating Literary Quotes List
Quote.create!(quote_list: ql1,
  text: 'Not all those who wander are lost. ~J.R.R. Tolkien')
Quote.create!(quote_list: ql1,
  text: "The mystery of life isn\'t a problem to solve, but a reality to be experienced. ~Frank Herbert")
Quote.create!(quote_list: ql1,
  text: "I know not all that may be coming, but be it what it will, I\'ll go to it laughing. ~Herman Melville")
Quote.create!(quote_list: ql1, text: 'The simplr things are also the most extraordinary things, and only the wise can see them. ~Paolo Coehlo')
Quote.create!(quote_list: ql1, text: "You asked me how to get out of the finite dimenstions when I feel like it. I certainly don\'t use logic when I do it. Logic\'s the first thing you have to get rid of. ~J.D. Salinger")


#Creating Spiritual Quotes List
Quote.create!(quote_list: ql2, text: 'Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor. ~Thich Nhat Hanh')
Quote.create!(quote_list: ql2, text: 'Work is not always required. There is such a thing as sacredleness. ~George MacDonald')
Quote.create!(quote_list: ql2, text: 'I have lived with several Zen masters -- all of them cats. ~Eckhart Tolle')
Quote.create!(quote_list: ql2, text: 'Undisturbed calmness of mind is attained by cultivating friendliness toward the happy, compassion for the unhappy, delight in the virtuous, and indifference toward the wicked. ~Patanjali')
Quote.create!(quote_list: ql2, text: 'If we learn to open our hearts, anyone, including the people who drive us crazy, can be our teacher. ~Pema Chodron')
Quote.create!(quote_list: ql2, text: "We don\'t set out to save the world; we set out to wonder how other people are doing and reflect on how our actions affect other people\'s hearts. ~Pema Chodron")

