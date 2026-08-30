# Практикум по физической химии (5 семестр)

Репозиторий содержит лабораторный практикум по физической химии. Каждый
практикум находится в отдельной папке и включает исходные данные, Jupyter-
ноутбук с расчётами, результаты обработки и компилируемый документ Typst.
В конце каждого практикума есть раздел «Ответы на контрольные вопросы».

## Об авторстве

Экспериментальные данные, расчёты и их обработка была выполнена мной самостоятельно.
Ответы на контрольные вопросы первоначально были написаны вручную в
тетради, а в электронной версию дополнены и отредактированы с помощью
нейросети для полноты, поэтому отнеситесь к ним с осторожностью) Ко всем данным 
подойдите как к референсу, а не абсолютному идеалу. Если вы заметите ошибки или зхотите 
дополнить этот репозиторий, пишите в issues или мне лично. Надеюсб данные 
материалы помогут вам в изучении кинетики, удачи!

## Структура

```
settings.typ                    # общая конфигурация стиля для всех документов
macros.typ                      # общие функции (секции, таблицы, рисунки, формулы в рамке)
practicum.typ                   # сводный документ: титульный лист + оглавление + все практикумы
README.md                       # это описание проекта

kinetics-in-solutions/          # 1. Кинетика реакций в растворах
  kinetics-in-solutions.ipynb   #    работающий ноутбук
  data/                         #    исходные данные (1.txt–4.txt)
  output/                       #    графики, r2s.csv
  main.typ                      #    отчёт Typst

enzyme-kinetics/                # 2. Исследование кинетики ферментативной реакции
  enzyme-kinetics.ipynb
  data/                         #    1.csv–6.csv
  output/                       #    графики, velocities.csv
  main.typ

homogeneous-catalysis/          # 3. Кинетика каталитических реакций (гомогенный катализ)
  homogeneous-catalysis.ipynb
  data/                         #    25.csv, 35.csv, 45.csv (исходные данные)
  output/                       #    графики, обработанные CSV
  main.typ

conductometry/                  # 4. Гидролиз сложного эфира, кондуктометрия
  conductometry.ipynb
  data/                         #    exp1–3.txt, T1–3.txt
  output/                       #    графики, CSV-результаты
  main.typ

photochemical-peroxide/         # 5. Фотохимическое разложение пероксида водорода
  photochemical-peroxide.ipynb
  data/                         #    prak5.csv (исходные данные)
  output/                       #    prak5.csv, prak5.png
  main.typ

photochemical-iron/             # 6. Фотохимическое разложение ферриоксалат-иона
  photochemical-iron.ipynb
  data/                         #    prak7.csv (измерения A)
  output/                       #    fe-c-t.png, fe-n-t.png, prak7.csv
  main.typ

heterogeneous-catalysis/        # 7. Разложение H2O2 на Pt-катализаторе
  heterogeneous-catalysis.ipynb
  data/                         #    1.csv–3.csv (исходные данные)
  output/                       #    графики, final.csv, final_separate_uncs.csv
  main.typ

quasi-stationary-approximations/ # 8. Квазистационарное и квазиравновесное приближения
  quasi-stationary-approximations.ipynb
  output/                       #    case1–4.png
  main.typ

oscillating-reactions/          # 9. Колебательные реакции (Лотка–Вольтерра, брюсселятор, …)
  oscillating-reactions.ipynb
  output/                       #    графики
  main.typ
```

Каждая папка практикума содержит следующие основные элементы:

- `main.typ` - текст и оформление отчёта Typst;
- `main.pdf` - скомпилированный отчёт;
- `*.ipynb` - ноутбук с расчётами и построением графиков;
- `data/` - исходные экспериментальные или модельные данные;
- `output/` - графики и файлы с результатами обработки.

## Идея обработки данных

Все данные экспортируются из Jupyter-ноутбука - графики (`output/*.png`)
и результаты в виде CSV (`output/*.csv`). Внутри документов Typst
(`main.typ`) эти файлы подключаются: изображения через `image()`, а числовые
результаты переносятся в таблицы отчётов. Поэтому все результаты обработки
данных отображаются внутри итогового документа.

Регрессии выполняются через `uncertainty-tools` (`from unc_tools import UncRegression`)
с оценкой погрешностей коэффициентов; в вычислительных практикумах системы
кинетических ОДУ записываются вручную и интегрируются `scipy.integrate`
(`odeint`/`solve_ivp`).

## Окружение (uv)

Проект использует `uv` для управления зависимостями и ядром ноутбуков:

```bash
uv sync                                   # создать .venv из uv.lock
uv run python -c "from unc_tools import UncRegression; print('ok')"

# пересчёт всех ноутбуков ядром проекта (без старого kernelspec)
uv run jupyter nbconvert --to notebook --execute --inplace \
  kinetics-in-solutions/kinetics-in-solutions.ipynb
```

Ядро `physchem-uv` регистрируется в `.venv/share/jupyter/kernels/` скриптом
`scripts/register-kernel.sh`; все ноутбуки ссылаются на него в `metadata.kernelspec`.

## Сборка

Документы компилируются из корня проекта (общие файлы `settings.typ` и
`macros.typ` лежат в корне):

```bash
# отдельный практикум
typst compile --root . kinetics-in-solutions/main.typ

# сводный документ (титульный лист + все практикумы)
typst compile --root . practicum.typ

# пересчёт ноутбуков (папка output/ заполняется заново)
uv run jupyter nbconvert --to notebook --execute --inplace kinetics-in-solutions/kinetics-in-solutions.ipynb
```
