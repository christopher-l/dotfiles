// Adapted from https://github.com/typst/templates/blob/main/letter/template.typ and
// https://github.com/pascal-huber/typst-letter-template/

#let letter_page_margin = (
  top: 26mm,
  bottom: 40mm,
  left: 26mm,
  right: 26mm,
)

#let letter_indicator_lines(fold_marks: (), show_puncher_mark: false) = {
    for mark in fold_marks {
        place(
            dy: mark - letter_page_margin.top,
            dx: 0cm - letter_page_margin.left + 3.5mm,
            line(
                length: 0.2cm, 
                stroke: 0.2pt
            )
        )
    }
    if show_puncher_mark {
        place(
            dy: 50% - 0.5 * letter_page_margin.top + 0.5 * letter_page_margin.bottom,
            dx: 0cm - letter_page_margin.left + 3.5mm,
            line(
                length: 0.4cm, 
                stroke: 0.2pt
            )
        )
    }
}

#let letter_sender(sender) = {
  let sender_rect = rect(
    inset: 0pt,
    stroke: none,
    {
        sender.name
        linebreak()
        sender.address.join([\ ])
        if "phone" in sender [
          \ Telefon: #sender.phone
        ]
        if "email" in sender [
          \ E-Mail: #link("mailto:" + sender.email)
        ]
    }
  )
  place(
    dy: 8.6mm - letter_page_margin.top,
    dx: 20mm - letter_page_margin.left,
    sender_rect
  )
}

#let letter_return_to(sender) = {
  let return_to_rect = rect(
    inset: (top: 0pt, left: 0pt, right: 0pt, bottom: 4pt),
    stroke: (bottom: 0.4pt),
    text(size: 7pt, font: "Cantarell")[#sender.name, #sender.address.join(", ")]
  )
  place(
    dy: 48mm - letter_page_margin.top,
    dx: 20mm - letter_page_margin.left,
    return_to_rect
  )
}

#let letter_recipient(recipient) = {
  let recipient_rect = rect(
    inset: 0pt,
    height: 37mm,
    width: 40mm,
    stroke: none,
    align(horizon)[
      #recipient
    ]
  )
  place(
    dy: 52mm - letter_page_margin.top,
    dx: 20mm - letter_page_margin.left,
    recipient_rect
  )
}

#let letter_date(date) = {
  place(
    right,
    dy: 100mm - letter_page_margin.top,
    rect(
      inset: 0pt,
      stroke: none,
      if type(date) == "datetime" {
        date.display("[day]. [month repr:long] [year]")
      } else {
        date
      }
    )
  )
}

#let letter(
  // The letter's sender, which is display at the top of the page.
  sender: none,
  // The letter's recipient, which is displayed close to the top.
  recipient: none,
  // The date, displayed to the right.
  date: datetime.today(),
  // The subject line.
  subject: none,
  closing: none,
  // The letter's content.
  body
) = {
  set page(
    margin: letter_page_margin,
    footer: {
      set align(center)
      // Display the page number starting with page 2
      locate(loc => {
        if counter(page).at(loc).at(0) > 1 [
          Seite #counter(page).display()
        ]
      })
    }
  )
  set block(spacing: 1.5em)
  set par(justify: true)
  set text(lang: "de")

  letter_indicator_lines(fold_marks: (105mm, 210mm), show_puncher_mark: true)
  letter_sender(sender)
  letter_return_to(sender)
  letter_recipient(recipient)
  letter_date(date)

  v(110.8mm - letter_page_margin.top)

  // Add the subject line, if any.
  if subject != none {
    pad(right: 10%, strong(subject))
    v(1.5em)
  }

  // Add body and name.
  body
  v(1.5em)
  block(breakable: false, {
    closing
    v(1.25cm)
    sender.name
  })
}
