topics = [
  {name: "Sport", children: [
    "Piłka Nożna",
    "Siatkówka",
    "NBA",
    "Wyścigi samochodowe",
    "Bieganie"
  ]},
  {name: "Muzyka", children: [
    "Muzyka Klasyczna",
    "Lata 70",
    "Lata 80",
    "Lata 90",
    "Muzyka współczesna",
    "Instrumenty",
    "Pop",
    "Rock",
    "Rap i Hiphop",
    "Muzyka elektroniczna",
    "Muzycy i artyści",
    "Teksty piosenek"
  ]},
  {name: "Literatura", children: [
    "Cytaty",
    "Poezja",
    "Komiksy",
    "Pisarze",
    "Postacie literackie",
    "Literatura dziecięca",
    "Lektury szkolne",
    "Literatura polska",
    "Literatura obcojęzyczna",
    "Fantastyka",
    "Klasyka",
    "Harry Potter",
    "Igrzyska Śmierci",
    "Zmierzch",
    "Władca Pierścieni",
    "Biblia"
  ]},
  {name: "Natura", children: [
    "Zwierzęta",
    "Zwierzęta domowe",
    "Ptaki",
    "Dinozaury",
    "Owady",
    "Ssaki",
    "Gady",
    "Ryby",
    "Rośliny",
  ]},
  {name: "Sztuka", children: [
    "Artyści",
    "Fotografia",
    "Malarstwo",
    "Kolory",
    "Architektura"
  ]},
  {name: "Telewizja", children: [
    "Seriale",
    "Gra o Tron",
    "Gotowe na wszystko",
    "Zmiennicy",
    "Klan",
    "Moda na Sukces"
  ]},
  {name: "Historia", children: [
    "Prehistoria",
    "Starożytność",
    "Średniowiecze",
    "I Wojna Światowa",
    "II Wojna Światowa",
    "Historia Współczesna",
    "Historia Polski"
  ]},
  {name: "Filmy", children: [
    "Oskary",
    "Aktorzy i aktorki",
    "James Bond",
  ]},
  {name: "Geografia", children: [
    "Państwa",
    "Stolice Państw",
    "Miasta Świata",
    "Miasta Europy",
    "Miasta Polski",
    "Europa",
    "Ameryka Południowa",
    "Ameryka Północna",
    "Azja",
    "Afryka",
    "Geografia świata",
    "Geografia Polski"
  ]},
  {name: "Nauka", children: [
    "Chemia",
    "Pierwiastki",
    "Fizyka",
    "Kosmos i Wszechświat",
    "Informatyka",
    "Meteorologia",
    "Geologia",
    "Biologia",
    "Medycyna",
    "Ciało człowieka",
    "Matematyka"
  ]},
  {name: "Gry i rozrywka", children: [
    "Gry komputerowe",
    "Konsole",
    "Klasyka gier",
    "World of Warcraft",
    "Minecraft",
    "Pokemon",
    "Gry karciane"
  ]},
  {name: "Technologie i branża IT", children: [
    "Internet",
    "Gadżety",
    "Apple",
    "iPhone",
    "PC",
    "Microsoft",
    "Firmy IT",
    "Linux",
    "Android",
    "Programy",
    "Programowanie"
  ]},
  {name: "Życie codzienne", children: [
    "Samochody",
    "Owoce i warzywa",
    "Zdrowie",
    "Przyprawy",
    "Transport",
    "Jedzenie",
    "Wydarzenia"
  ]}
]

puts "Creating topics:"

counter = 0

topics.each do |t|
  topic = Topic.create!({name: t[:name]})
  counter += 1
  puts "Created topic: #{topic.name}"
  if t[:children] != nil
    t[:children].each do |child|
      if child.is_a? String
        hash = {name: child, parent_id: topic.id}
      else
        hash = child
        hash[:parent_id] = topic.id
      end
      child_topic = Topic.create!(hash)
      counter += 1
      puts "  - Child topic: #{child_topic.name}"
    end
  end
end

puts "Rebuilding Topic tree..."
Topic.rebuild!
puts "Done!"

puts "Total #{counter} topics created. Seed finished"