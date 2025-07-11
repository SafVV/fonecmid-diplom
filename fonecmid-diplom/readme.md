# Инструкция по начальной настройке
## Настройка ролей
Пользователь с правами Администратор создает профили групп доступа (Администрирование – Настройка пользователей и прав – Профили групп доступа):
- «Специалист» и подключает добавленные роли - ВКМ добавление изменение обслуживание клиента, ВКМ подсистема добавленные объекты, ВКМ работа с отчетом выработка специалистов.
- «Менеджер» и подключает добавленные роли - ВКМ добавление изменение обслуживание клиента, ВКМ использование обработки календарь, ВКМ подсистема добавленные объекты.
- «БухгалтерИТФирмы» и подключает добавленные роли - ВКМ использование обработки массовое создание актов, ВКМ подсистема добавленные объекты, ВКМ работа с отчетом анализ выставленных актов.
- «КадровикРасчетчик» и подключает добавленные роли - ВКМ добавление изменение выплаты зарплаты, ВКМ добавление изменение графиков отпусков, ВКМ добавление изменение начисления зарплаты, ВКМ добавление изменение начисления фиксированной премии, ВКМ подсистема добавленные объекты, ВКМ работа с отчетом выработка специалистов, ВКМ работа с отчетом расход запланированных отпусков, ВКМ работа с отчетом расчеты с сотрудниками.

## Заполнение справочников по ролям
- Пользователь с правами Кадровик-расчетчик заполняет справочники: Физические лица, Подразделения, Графики работы.
- Пользователь с правами Кадровик-расчетчик заполняет регистр Графики работы используя обработку для автоматического заполнения «Заполнение графика работы», заполнив соответствующие поля.
- Пользователь с правами Кадровик-расчетчик заполняет регистр Условия оплаты сотрудников.

## Работа с ТГ ботом
- Пользователь с правами Администратор заполняет константы (Добавленные объекты – Сервис): Токен управления телеграм ботом, Идентификатор группы для оповещения, Номенклатура абонентская плата, Номенклатура работы специалиста.

# Инструкция по запуску сценариев тестирования
## Состав сценариев тестирования:
1.	МенеджерСозданиеОбслуживаниеКлиента.
2.	СпециалистПроведениеДокументаОбслуживаниеКлиента.
3.	БухгалтерМассовоеСозданиеДокументов.
4.	БухгалтерОтчетАнализВыставленныхАктов.

## Порядок действий тестирования
1.	Выгрузить dt рабочей базы. 
2.	Добавить новую тестовую базу.
3.	В тестовую базу загрузить dt рабочей базы. 
4.	В конфигураторе тестовой базы снимите флаг «Защита от опасных действий» у пользователей Менеджер, Специалист, Бухгалтер.
5.	Запустите тестовую базу, при запуске укажите, что база перемещена(это копия базы). 
6.	Скачайте внешнюю обработку vanessa-automation-single.epf.
7.	В дополнительных параметрах запуска тестовой базы пропишите /TestManager.
8.	Запустите тестовую базу под пользователем Администратор. 
9.	Откройте внешнюю обработку vanessa-automation-single.epf.
10.	После запуска обработки перейдите на вкладку Клиенты тестирования, убедитесь, что тестовая база прописана как клиент тестирования. При необходимости пропишите её.
    
### Тестирование:
1.	Нажмите кнопку Загрузить фичи.
2.	Укажите путь к файлам сценариев.
3.	Выберите сценарий. Сценарии тестирования следует запускать в следующей очерёдности:
•	МенеджерСозданиеОбслуживаниеКлиента от имени Менеджера.
•	СпециалистПроведениеДокументаОбслуживаниеКлиента от имени Специалиста 1.
•	БухгалтерМассовоеСозданиеДокументов от имени Бухгалтера.
•	БухгалтерОтчетАнализВыставленныхАктов от имени Бухгалтера.
4.	Для каждого сценария, в настройках клиента тестирования необходимо прописывать пользователя, от имени которого будет запущен сценарий.
5.	Запустите выбранный сценарий.
6.	Должен запуститься клиент тестирования от имени пользователя, который указан в настройках клиента тестирования сценарии.
7.	Следите за выполнением сценария на клиенте тестирования.
8.	После завершения сценария вы получите звуковое и оповещение о завершении сценария. Сам сценарий окрасится в зеленый цвет. 
9.	На этом работа с сценариями тестирования завершена.

