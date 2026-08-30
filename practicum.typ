// Сводный практикум по физической химии — титульный лист, оглавление
// и все практикумы.
#import "settings.typ": config
#import "macros.typ": *

#show: config

#v(1cm)

#align(center)[
  #text(size: 16pt, weight: "bold")[Московский Государственный
    Университет]
  #linebreak()
  #text(size: 16pt, weight: "bold")[им. М.В.Ломоносова]

  #v(5cm)

  #text(size: 24pt, weight: "bold")[Лабораторный журнал]

  #v(1cm)

  #text(size: 14pt, weight: "bold")[по дисциплине: «Физическая химия»]

  #v(3cm)

  #align(right)[
    #text(size: 12pt)[
      *Выполнил:* \
      студент 3 курса, 311 группы \
      Саватейкин Я.М. \
      *Преподаватель:* \
      доц., д.х.н. Голубина Е.В. \
      доц., к.ф.-м.н. Бойченко А.Н.
    ]
  ]

  #v(2.5cm)

  #text(size: 12pt)[Москва — 2026]
]

#pagebreak()

#outline(title: "Содержание", depth: 1, indent: 0.5em)

#pagebreak()

#include "kinetics-in-solutions/main.typ"
#include "enzyme-kinetics/main.typ"
#include "homogeneous-catalysis/main.typ"
#include "conductometry/main.typ"
#include "photochemical-peroxide/main.typ"
#include "photochemical-iron/main.typ"
#include "heterogeneous-catalysis/main.typ"
#include "quasi-stationary-approximations/main.typ"
#include "oscillating-reactions/main.typ"
