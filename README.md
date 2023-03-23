# ContactsList

# Дизайн

[Дизайн в Figma](https://www.figma.com/file/kphpoqW0h9LsDgNXhqsbcH/YP-Contacts-(iOS)?node-id=3%3A2584)

# Назначение и цели приложения

Приложение, предназначенное для просмотра и работы с контактами, которые доступны на мобильном телефоне пользователя.

Цели приложения:

- Отображение списка контактов при получении разрешения на доступ к телефонной книге
- Фильтрация и сортировка списка, удаление контактов

# Функциональные требования

## Вход

**Экран входа содержит:**

1. Splash screen
2. Системный алерт на разрешение доступа к контактам 

**Алгоритмы и доступные действия:**

1. При входе в приложение пользователь видит splash-screen;
2. После первого входа в приложение пользователь видит системный алерт на разрешение доступа к контактам на телефоне 
    - При нажатии на кнопку разрешения доступа пользователь видит экран со списком контактов  
    - При нажатии на кнопку отказа давать доступ, пользователь видит экран списка контактов с кнопкой «Хочу увидеть свои контакты»
    - При нажатии на кнопку «Хочу увидеть свои контакты» пользователь оказывается в настройках приложения, где есть свитчер Contacts и может дать доступ к контактам

## Список контактов

При наличии у приложения доступа — пользователь может видеть список своих контактов c фотографиями и отображением доступных мессенджеров, листать, сортировать и фильтровать его, удалять контакты. 

**Экран списка контактов содержит:**

1. Список ячеек, каждая их которых содержит информацию о контакте
    - Если применены фильтры, с набором которых нет ни одного контакта, показывается экран с надписью «Таких контактов нет, выберите другие фильтры»
2. Кнопку фильтрации
    - Если применены какие-либо параметры фильтрации — на кнопке есть красный бэйдж
    
3. Кнопку сортировки  
    - Если применены какие-либо параметры сортировки — на кнопке есть красный бэйдж
 
4. Конкретная ячейка контакта содержит:
    - Имя и фамилию контакта, если они есть
    - Фотографию, привязанную к контакту при её наличии.
        - Если фотографии нет, то пользователь видит на её месте плэйсхолдер
    - Номер телефона с маской для российского мобильного номера (вида +7 (000) 000-00-00) и без неё для других номеров.
        - Номер отображается, если он есть у конкретного контакта
    - Набор иконок, каждая из которых обозначает наличие у контакта мессенджеров, номера телефона и почты
        - Доступные для отображения мессенджеры: Telegram, WhatsApp, Viber, Signal, Threema
    

**Алгоритмы и доступные действия:**

1. Пролистывать список контактов
2. Нажать на иконку фильтров и увидеть модальное окно с параметрами
3. Нажать на иконку сортировки и увидеть модальное окно с типами сортировки

## Фильтрация

Модальное окно позволяет выбрать параметры контактов и показывать список только с теми, которые им соответствуют.  

**Модальное окно фильтрации содержит:**

1. Набор параметров для фильтрации с чек-боксами
2. Кнопку «Применить»
3. Кнопку «Сбросить»

**Алгоритмы и доступные действия:**

1. Выбирать нажатием на чек-бокс нужные параметры
    - На чекбокс можно нажать, при этом отображается синяя галочка и параметр будет участвовать в выдаче при применении фильтра
    - Можно выбрать несколько чек-боксов одновременно
    - Чекбокс можно отжать, при этом галочка пропадает и параметр не будет участвовать в выдаче при применении фильтра
    - При нажатии на «Выбрать все» — галочка ставятся напротив каждого параметра 
    - Доступные фильтры: Выбрать все, Telegram, WhatsApp, Viber, Signal, Threema, Номер телефона, Email
2. Сбросить выбранные параметры
    - После нажатия кнопки все выбранные чек-боксы отжимаются
    - Если нажать после этого «Применить», то модельное окно скроется и пользователь увидит на экране списка все контакты 
3. Применить выбранные параметры — увидеть список контактов, у которого есть каждый из выбранных атрибутов (например, при выборе «Номер телефона» и «email» пользователь должен увидеть выдачу только из контактов и с номером, и с почтой)
    - После применения выбранных параметров модальное окно скрывается и пользователь видит экран списка контактов
    - Если по выбранным параметрам есть контакты — пользователь список, полностью соответствующий выбранным чек-боксам
    - Если по выбранным параметрам нет контактов — пользователь видит на экране списка надпись «Таких контактов нет, выберите другие фильтры»
4. Смахнуть вниз
    - Можно смахнуть экран вниз, фильтры при этом не применятся

## Сортировка

Модальное окно позволяет выбрать тип последовательности, по которой список контактов будет отсортирован. 

**Модальное окно сортировки содержит:**

1. Набор типов сортировки с радио-баттонами
2. Кнопку «Применить»
3. Кнопку «Сбросить»

**Алгоритмы и доступные действия:**

1. Выбирать нажатием на один радио-баттон последовательность, в которой контакты будут расположены на экране списка. 
    - На радиобаттон можно нажать, при этом отображается синий кружок внутри выбранного типа сортировки, контакты будут расположены в той последовательности, которая задана 
    - Одновременно может быть выбран только один тип сортировки 
    - Доступные типы: По имени от A до Я (от A до Z), по имени от Я до А (от A до Z), по фамилии от A до Я (от A до Z), по фамилии от Я до А (от A до Z). 
2. Сбросить выбранный тип сортировки
    - После нажатия на кнопку выбранный радио-баттон отжимается
    - Если нажать после этого «Применить», то модельное окно скроется и пользователь увидит на экране списка контакты в изначальном порядке
3. Применить выбранный тип сортировки — увидеть список контактов, расположенный в нужном порядке, или с начала алфавита к концу, или наоборот.
    - После применения выбранных параметров модальное окно скрывается и пользователь видит экран списка контактов
4. Смахнуть вниз
    - Можно смахнуть экран вниз, сортировка при этом не применятся

## Удаление контакта

Находясь на экране списка контактов, пользователь может удалять их. 

**Алгоритмы и доступные действия:**

- Карточку контакта можно свайпнуть влево, при свайпе до конца снизу появляется системное меню с действиями Удалить и Отменить 
- Удалить — при нажатии контакт удаляется из списка, системное меню скрывается, удалённого контакта нет в списке
- Отменить — при нажатии меню скрывается, контакт не удаляется из списка 

# Нефункциональные требования

## Технические требования

1. Список контактов реализован с помощью UITableView.
2. В приложении использован UIContextualAction
3. Приложение должно поддерживать устройства iPhone с iOS 13 или выше, предусмотрен только портретный режим.
4. В приложении используется системный шрифт — SF Pro (San Francisco Pro)

