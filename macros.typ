// macros.typ — общие функции для оформления практикумов.
// Подключение: #import "../macros.typ": *

// Заголовок секции с номером и названием.
#let section(number, title) = heading(level: 2)[#number. #title]

// Подпись под таблицей/рисунком — курсив, по центру
#let note(body) = [
  #v(0.25em)
  #set text(size: 10.5pt, style: "italic", fill: rgb("#333333"))
  #align(center)[#body]
]

// Таблица из массива заголовков и массива строк.
#let datatable(headers, rows, caption: none, align: none) = {
  let cols = headers.len()
  let al = if align == none {
    (center,) * cols
  } else {
    align
  }
  figure(
    table(
      columns: cols,
      inset: 6pt,
      align: al,
      ..headers.map(h => table.cell(strong(h))),
      ..rows.flatten().map(c => table.cell(c)),
    ),
    caption: caption,
    numbering: "1",
  )
}

// Рисунок с нумерацией и, при необходимости, меткой для #ref.
// Пример: #plot("output/curve.png", caption: [Кривая], tag: "fig-curve")
#let plot(path, caption: none, width: 85%, tag: none) = {
  let fig = figure(
    image(path, width: width),
    caption: caption,
    numbering: "1",
  )
  if tag == none { fig } else { [#fig #label(tag)] }
}

// Ссылка на нумерованный рисунок. Метка должна быть передана строкой.
#let figref(tag) = ref(label(tag))

// Единый минималистичный заголовок каждого отчёта.
#let practicum-title(title) = [
  #text(size: 9pt, fill: rgb("#555555"))[ЛАБОРАТОРНЫЙ ПРАКТИКУМ · ФИЗИЧЕСКАЯ ХИМИЯ]
  #v(0.25em)
  #heading(level: 1)[#title]
  #v(0.2em)
  #line(length: 100%, stroke: 0.5pt + rgb("#777777"))
  #v(0.6em)
]

// Формула в рамке; dash: true — пунктирная рамка (аналог \dashboxed)
#let boxeq(body, dash: false) = {
  let st = if dash {
    (paint: black, thickness: 0.6pt, dash: "dashed")
  } else {
    (paint: black, thickness: 0.6pt)
  }
  align(
    center,
    box(stroke: st, inset: (x: 10pt, y: 5pt), radius: 2pt, body),
  )
}

// Неопределённость вида a ± b
#let pm(a, b) = $ #a #sym.plusminus #b $

// Блок «контрольный вопрос → короткий ответ».
#let qas(questions) = {
  let i = 0
  for q in questions {
    i += 1
    block(
      [
        #text(weight: "bold")[Вопрос #i. #q.at(0)]
        #v(0.2em)
        #block(
          [#q.at(1)],
          width: 100%,
          stroke: (left: 0.6pt + rgb("#777777")),
          inset: (left: 7pt),
        )
        #v(0.5em)
      ],
      breakable: false,
    )
  }
}

// Заголовок раздела ответов без дополнительного декоративного оформления.
#let questions-section(title: "Ответы на контрольные вопросы") = {
  heading(level: 2)[#title]
}
