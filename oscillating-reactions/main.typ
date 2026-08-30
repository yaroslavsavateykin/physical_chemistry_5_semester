// Колебательные реакции (практикум 8)
// Лотка–Вольтерра, брюсселятор, орегонатор, Бриггс–Раушер
#import "../settings.typ": config
#import "../macros.typ": *

#show: config

#practicum-title([Колебательные реакции])

#section(1, "Задачи")

1. Получить аналитические выражения для стационарных концентраций промежуточных реагентов в схеме Лотки.
2. Используя численное интегрирование (пакет Kinet), подтвердить полученные выражения.
3. Определить, как зависит период колебательной реакции от концентраций веществ $A$ и $B$ в схеме Лотки–Вольтерры.
4. Определить, как зависит период колебаний от коэффициентов скорости элементарных стадий реакции в схеме Лотки–Вольтерры.
5. Предложить соотношения концентраций начальных веществ, при которых система будет генерировать колебания, и при которых колебаний не будет в приближении брюсселятора.
6. Привести примеры модели орегонатора с колебаниями промежуточных компонентов и без.
7. Продемонстрировать двойные колебания в модели для реакции Бриггса–Раушера.

#pagebreak()

#section(2, "Нахождение аналитического решения")

Схема Лотки:

$
  cases(
    (dif [A])/(dif t) = -k_1 [A] + k_2 [B],
    (dif [B])/(dif t) = k_1 [A] - (k_2 + k_3) [B],
    (dif [C])/(dif t) = k_3 [B]
  )
$

#boxeq($ A + B + C = A_0 $, dash: true)

Уравнение второго порядка для $A$. Из первого уравнения:

$
  [B] = 1/k_2 ((dif [A])/(dif t) + k_1 [A]) \
  ↓ dot (dif)/(dif t) \
  (dif [B])/(dif t) = 1/k_2 ((dif^2 [A])/(dif t^2) + k_1 (dif [A])/(dif t))
$

Подставляя во второе уравнение системы:

$
  1/k_2 ((dif^2 [A])/(dif t^2) + k_1 (dif [A])/(dif t)) = k_1 [A] - (k_2 + k_3) 1/k_2 ((dif [A])/(dif t) + k_1 [A]) \
  ↓ \
  (dif^2 [A])/(dif t^2) + (k_1 + k_2 + k_3) (dif [A])/(dif t) + k_1 k_3 [A] = 0
$

Начальные условия для $[A]$:

$ (dif [A])/(dif t) |_(t=0) = -k_1 A_0 $

Решение уравнения для $A$:

$ A = alpha e^(lambda_1 t) + beta e^(lambda_2 t) $

Характеристическое уравнение:

$
  lambda^2 + (k_1 + k_2 + k_3) lambda + k_1 k_3 = 0 \
  ↓
$

#boxeq(
  $ lambda_(1,2) = -(k_1 + k_2 + k_3)/2 plus.minus 1/2 sqrt((k_1 + k_2 + k_3)^2 - 4 k_1 k_3) $,
  dash: true,
)

Система для определения коэффициентов:

$
  cases(
    A = alpha e^(lambda_1 t) + beta e^(lambda_2 t),
    (dif A)/(dif t) = alpha lambda_1 e^(lambda_1 t) + beta lambda_2 e^(lambda_2 t)
  ) \
  attach(arrow.r.double, t: t = 0) \
  cases(
    alpha + beta = A_0,
    alpha lambda_1 + beta lambda_2 = -k_1 A_0
  )
$

Подставляя найденные $alpha$ и $beta$:

#boxeq(
  $ A = A_0 ((k_1 + lambda_1) e^(lambda_2 t) - (k_1 + lambda_2) e^(lambda_1 t))/(lambda_1 - lambda_2) $
)

Решение для $B$. Подставляем $A(t)$ и $(dif A)/(dif t)$ в первое уравнение и получаем связь между коэффициентами у $e^(lambda t)$:

$ lambda_i A_(lambda_i) = -k_1 A_(lambda_i) + k_2 B_(lambda_i) space arrow.r.double space B_(lambda_i) = (k_1 + lambda_i)/k_2 A_(lambda_i) $

Тогда:

$ B = alpha (k_1 + lambda_1)/k_2 e^(lambda_1 t) + beta (k_1 + lambda_2)/k_2 e^(lambda_2 t) $

Подставляя найденные $alpha, beta$ и упрощая, получаем очень простую форму:

#boxeq($ B = A_0 k_1/(lambda_1 - lambda_2) (e^(lambda_1 t) - e^(lambda_2 t)) $)

Решение для $C$:

$ C = A_0 - A - B $

Подставляем выражения для $A$ и $B$:

#boxeq(
  $ C = A_0 (lambda_1 (1 - e^(lambda_2 t)) - lambda_2 (1 - e^(lambda_1 t)))/(lambda_1 - lambda_2) $
)

#pagebreak()

#section(3, "Построение графиков численно и аналитически")

#grid(
  columns: 2,
  column-gutter: 1em,
  [#plot("oscillating-reactions/output/num_sol.png", width: 100%, caption: [Численное решение схемы Лотки], tag: "fig-lotka-numerical")],
  [#plot("oscillating-reactions/output/num_vs_analytic.png", width: 100%, caption: [Численное и аналитическое решения], tag: "fig-lotka-compare")],
)

#section(4, "Зависимость периода колебательной реакции от концентраций веществ $A$ и $B$ в схеме Лотки–Вольтерры")

$
  cases(
    (dif X)/(dif t) = k_1 A X - k_2 X Y,
    (dif Y)/(dif t) = k_2 X Y - k_3 B Y
  )
$

Стационарная точка:

$ X^* = (k_3 B)/k_2, quad Y^* = (k_1 A)/k_2 $

$ X = X^* + x, quad Y = Y^* + y $

Подстановка в уравнения:

$
  (dif x)/(dif t) = k_1 A x - k_2 (X^* y + Y^* x) \
  (dif y)/(dif t) = k_2 (Y^* x + X^* y) - k_3 B y
$

Используем равенства стационарности:

$ k_1 A - k_2 Y^* = 0, quad k_2 X^* - k_3 B = 0 $

Тогда:

$
  (dif x)/(dif t) = -k_3 B y \
  (dif y)/(dif t) = k_1 A x
$

Дифференцируем первое уравнение:

$ (dif^2 x)/(dif t^2) = -k_3 B (dif y)/(dif t) $

Подставляем второе уравнение:

$ (dif^2 x)/(dif t^2) = -k_3 B (k_1 A x) $

Получаем уравнение осциллятора:

#boxeq($ (dif^2 x)/(dif t^2) + k_1 k_3 A B x = 0 $)

Частота и период:

#boxeq($ omega = sqrt(k_1 k_3 A B) $)

#boxeq($ T = (2 pi)/sqrt(k_1 k_3 A B) $)

#grid(
  columns: 2,
  column-gutter: 1em,
  [#plot("oscillating-reactions/output/conc_x_y_a_b.png", width: 100%, caption: [Сетка концентраций для $A$ и $B$], tag: "fig-lotka-conc")],
  [#plot("oscillating-reactions/output/period_ab.png", width: 100%, caption: [Период от произведения $A dot B$], tag: "fig-lotka-period-ab")],
)

#section(5, "Зависимость периода колебательной реакции от коэффициентов скорости элементарных стадий реакции в схеме Лотки–Вольтерры")

#grid(
  columns: 2,
  column-gutter: 1em,
  [#plot("oscillating-reactions/output/conc_x_y_k1_k3.png", width: 100%, caption: [Сетка концентраций для $k_1$ и $k_3$], tag: "fig-lotka-rates")],
  [#plot("oscillating-reactions/output/period_k1k3.png", width: 100%, caption: [Период от произведения $k_1 dot k_3$], tag: "fig-lotka-period-k")],
)

#section(6, "Анализ брюсселятора")

$
  cases(
    (dif X)/(dif t) = A + X^2 Y - (B + 1) X,
    (dif Y)/(dif t) = B X - X^2 Y
  )
$

#grid(
  columns: 2,
  column-gutter: 1em,
  [#plot("oscillating-reactions/output/brusselator.png", width: 100%, caption: [Траектории брюсселятора], tag: "fig-bruss-traces")],
  [#plot("oscillating-reactions/output/brusselator2.png", width: 100%, caption: [Карта режимов брюсселятора], tag: "fig-bruss-map")],
)

#section(7, "Анализ орегонатора")

#grid(
  columns: 2,
  column-gutter: 1em,
  [#plot("oscillating-reactions/output/oreganator.png", width: 100%, caption: [Траектории орегонатора], tag: "fig-oregon-traces")],
  [#plot("oscillating-reactions/output/oreganator2.png", width: 100%, caption: [Карта режимов орегонатора], tag: "fig-oregon-map")],
)

#section(8, "Двойные колебания в модели для реакции Бриггса–Раушера")

#grid(
  columns: 2,
  column-gutter: 1em,
  row-gutter: 1em,
  [#plot("oscillating-reactions/output/brigs-raush.png", width: 100%, caption: [Режим двойных колебаний], tag: "fig-briggs-all")],
  [#plot("oscillating-reactions/output/brigs-raush-x.png", width: 100%, caption: [$X(t)$], tag: "fig-briggs-x")],
  [#plot("oscillating-reactions/output/brigs-raush-y.png", width: 100%, caption: [$Y(t)$], tag: "fig-briggs-y")],
  [#plot("oscillating-reactions/output/brigs-raush-z.png", width: 100%, caption: [$Z(t)$], tag: "fig-briggs-z")],
)

#pagebreak()

#questions-section()

#qas((
  (
    [Что такое колебательные реакции и почему они возможны?],
    [
      Колебательные реакции — химические процессы, в которых концентрации промежуточных веществ периодически меняются во времени (автоколебания), не стремясь к стационарному состоянию. Они возможны, когда механизм содержит автокаталитические стадии, нелинейные по концентрации промежуточных веществ, и система далека от термодинамического равновесия (постоянный приток исходных веществ).
    ],
  ),
  (
    [Каковы стационарные концентрации в схеме Лотки и как они получены?],
    [
      В схеме $ arrow.r A, quad A + X arrow.r 2X, quad X + Y arrow.r 2Y, quad Y arrow.r $ стационарная точка находится из условия равенства нулю правых частей:
      $ X^* = (k_3 B)/k_2, quad Y^* = (k_1 A)/k_2 $. Они подтверждаются численным интегрированием (см. #figref("fig-lotka-numerical")) — система выходит на эти значения при больших $t$ (если параметры в области устойчивости).
    ],
  ),
  (
    [Как период зависит от концентраций $A$, $B$ и констант скоростей?],
    [
      Линеаризация около стационарной точки сводит систему к уравнению осциллятора $ (dif^2 x)/(dif t^2) + k_1 k_3 A B x = 0 $, откуда
      $ T = (2 pi)/sqrt(k_1 k_3 A B) $.
      То есть период обратно пропорционален $sqrt(A B)$ и $sqrt(k_1 k_3)$ — это подтверждается численными расчётами: см. #figref("fig-lotka-period-ab") и #figref("fig-lotka-period-k").
    ],
  ),
  (
    [Когда брюсселятор даёт колебания?],
    [
      Модель брюсселятора $ arrow.r A, quad A arrow.r X, quad 2X + Y arrow.r 3X, quad B + X arrow.r Y + D, quad X arrow.r $ имеет устойчивый предельный цикл при $B > 1 + A^2$. Если $B < 1 + A^2$, система стремится к устойчивому стационарному состоянию и колебаний нет. Эта граница видна на #figref("fig-bruss-map").
    ],
  ),
  (
    [Когда орегонатор даёт колебания?],
    [
      Орегонатор (модель Белоусова–Жаботинского) колеблется в определённой области параметров (например, по стехиометрическому коэффициенту $f$ и константе $k_5$): существуют области с колебаниями и без них. Карта режимов по $f$ и $k_5$ (#figref("fig-oregon-map")) показывает, при каких параметрах концентрации $X, Y, Z$ периодически меняются.
    ],
  ),
  (
    [Что демонстрирует модель Бриггса–Раушера?],
    [
      Модель Бриггса–Раушера воспроизводит двойные колебания — чередование колебаний малой и большой амплитуды (двухмасштабный предельный цикл). На #figref("fig-briggs-all") видно, что переменные $X, Y, Z$ испытывают периодические изменения разного масштаба, что и является характерной чертой двойных колебаний.
    ],
  ),
  (
    [Зачем нужна ручная запись систем ОДУ и численное интегрирование?],
    [
      Для колебательных схем аналитические решения в замкнутой форме, как правило, отсутствуют (нелинейные правые части), поэтому систему дифференциальных уравнений выписывают явно и интегрируют численно. Это позволяет проверить аналитические приближения (например, формулу периода), построить карты режимов и исследовать поведение системы в широком диапазоне параметров.
    ],
  ),
))
