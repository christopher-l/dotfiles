#import "@local/letter:0.1.0": letter
#show: letter.with(
  sender: (
    name: "Name",
    address: ("Straße Hausnummer", "Postleitzahl Ort"),
    phone: "+49 123 456789",
    email: "me@example.org"
  ),
  recipient: [
    Anrede \
    Name \
    Straße \ 
    \
    Ort
  ],
  date: "31. Dezember 2099",
  subject: "Betreff",
  closing: "Mit freundlichen Grüßen",
  enclosures: ("Foo", "Bar")
)

Sehr geehrte Damen und Herren,

#lorem(80)