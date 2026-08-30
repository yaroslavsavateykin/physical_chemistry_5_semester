// settings.typ — общая конфигурация стиля для всех практикумов.
// Подключается в каждом main.typ:
//   #import "../settings.typ": config
//   #show: config

#let config(body) = {
  // Страница A4 с нумерацией
  set page(paper: "a4", margin: 2cm, numbering: "1")

  // Основной текст
  set text(font: "New Computer Modern", size: 12pt, lang: "ru")
  set par(justify: true, leading: 0.5cm, spacing: 1.2em)

  // Математика
  show math.equation: set text(font: "New Computer Modern Math")
  set math.equation(numbering: none)

  // Заголовки: без автоматической нумерации (нумерация проставляется
  // вручную через макрос section из macros.typ)
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 16pt, weight: "bold")
  show heading.where(level: 2): set text(size: 13pt, weight: "bold")

  // Таблицы и рисунки
  set table(stroke: 0.5pt, inset: 6pt)
  set figure(numbering: none)
  show figure: set block(breakable: false)

  body
}
