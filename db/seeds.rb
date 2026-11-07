Activity.destroy_all

samples = [
  { title: "Yoga du matin", category: "yoga", duration: 30, date: Date.today, notes: "Respiration + étirements doux" },
  { title: "Méditation guidée", category: "meditation", duration: 15, date: Date.today, notes: "5 minutes calme + 10 minutes focus" },
  { title: "Marche légère", category: "marche", duration: 40, date: Date.today, notes: "Marche en plein air" },
  { title: "Routine sommeil", category: "soins", duration: 20, date: Date.today, notes: "Déconnexion écran + tisane" },
  { title: "Meal prep healthy", category: "nutrition", duration: 50, date: Date.today, notes: "Salade + protéines + fruits" }
]

Activity.create!(samples)
puts "✅ Seeds OK"