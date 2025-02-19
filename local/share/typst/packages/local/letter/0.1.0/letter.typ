// Adapted from https://github.com/typst/templates/blob/main/letter/template.typ and
// https://github.com/pascal-huber/typst-letter-template/
//
// Largely aims to reproduce the Latex Koma-Script letter class "scrlltr2".
//
// Currently supports German only.

#let letter(
  // The letter's sender, which is display at the top of the page.
  sender: none,
  // The letter's recipient, which is displayed close to the top.
  recipient: none,
  // The date, displayed to the right.
  date: datetime.today(),
  // The subject line.
  subject: none,
  // Closing phrase.
  closing: none,
  // List of enclosures, if any.
  enclosures: none,
  // The letter's content.
  body
) = {
  let page-margin = (
    top: 26mm,
    bottom: 40mm,
    x: 26mm,
  )

  let body-font = "Linux Libertine"
  let sans-font = "Noto Sans"

  let render-indicator-lines(fold_marks: (), show_puncher_mark: false) = {
      for mark in fold_marks {
          place(
              dy: mark - page-margin.top,
              dx: 3.5mm - page-margin.x,
              line(
                  length: 0.2cm, 
                  stroke: 0.2pt
              )
          )
      }
      if show_puncher_mark {
          place(
              dy: 50% - 0.5 * page-margin.top + 0.5 * page-margin.bottom,
              dx: 3.5mm - page-margin.x,
              line(
                  length: 0.4cm, 
                  stroke: 0.2pt
              )
          )
      }
  }

  let render-sender(sender) = {
    let sender_rect = rect(
      inset: 0pt,
      stroke: none,
      {
          sender.name
          linebreak()
          sender.address.join([\ ])
          if "phone" in sender [
            \ Telefon: #link("tel:" + sender.phone.replace(" ", ""))[#sender.phone]
          ]
          if "email" in sender [
            \ E-Mail: #link("mailto:" + sender.email)
          ]
      }
    )
    place(
      dy: 8.6mm - page-margin.top,
      dx: 20mm - page-margin.x,
      sender_rect
    )
  }

  let render-return-to(sender) = {
    let return_to_rect = rect(
      inset: 0pt,
      width: 75mm,
      stroke: none,
      rect(
        inset: (x: 0pt, top: 0pt, bottom: 4pt),
        stroke: (bottom: 0.4pt),
        text(size: 7pt, font: sans-font)[#sender.name, #sender.address.join(", ")]
      )
    )
    place(
      dy: 48mm - page-margin.top,
      dx: 20mm - page-margin.x,
      return_to_rect
    )
  }

  let render-recipeint(recipient) = {
    let recipient_rect = rect(
      inset: 0pt,
      height: 37mm,
      width: 75mm,
      stroke: none,
      align(horizon)[
        #recipient
      ]
    )
    place(
      dy: 52mm - page-margin.top,
      dx: 20mm - page-margin.x,
      recipient_rect
    )
  }

  let render-date(date) = {
    align(right, {
      if type(date) == "datetime" {
        show "January": "Januar"
        show "February": "Februar"
        show "March": "März"
        show "May": "Mai"
        show "June": "Juni"
        show "July": "Juli"
        show "October": "Oktober"
        show "December": "Dezember"
        date.display("[day padding:none]. [month repr:long] [year]")
      } else {
        date
      }
      v(1em)
    })
  }

  // Settings.
  set document(author: sender.name, title: subject)
  set page(
    margin: page-margin,
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
  set text(
    lang: "de",
    font: body-font
  )

  // Preamble. Each function uses absolute placement.
  render-indicator-lines(fold_marks: (105mm, 210mm), show_puncher_mark: true)
  render-sender(sender)
  render-return-to(sender)
  render-recipeint(recipient)

  // Date. From here on out, content is placed inside the regular page margins.
  v(98.5mm - page-margin.top)
  render-date(date)

  // Subject line.
  if subject != none {
    pad(right: 10%, strong(subject))
    v(1.5em)
  }

  // Body
  set par(justify: true)
  body

  // Closing and name.
  v(1.5em)
  block(breakable: false, {
    closing
    v(1.5cm)
    sender.name
  })

  // Enclosures.
  if enclosures != none {
    v(1.5em)
    block(breakable: false, {
      heading(level: 3)[Anlagen]
      list(marker: "-", ..enclosures)
    })
  }
}
