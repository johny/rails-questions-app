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
    "Harry Potter",
    "Igrzyska Śmierci",
    "Zmierzch",
    "Władca Pierścieni",
    "Biblia",
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
    "Kolory",
    "Architektura"
  ]},
  {name: "Telewizja", children: [
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
    "Klasyka gier",
    "World of Warcraft",
    "Minecraft",
    "Pokemon",
    "Gry karciane"
  ]},
  {name: "Technologie / IT", children: [
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

topics.each do |t|
  topic = Topic.create!({name: t[:name]})
  puts "Created topic: #{topic.name}"
  if t[:children] != nil
    t[:children].each do |child|
      name = (child.is_a?(String) ? child : child[:name])
      child_topic = Topic.create!({name: name, parent_id: topic.id})
      puts "  - Child topic: #{child_topic.name}"
    end
  end
end