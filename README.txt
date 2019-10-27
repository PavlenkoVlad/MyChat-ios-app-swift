Сервер уже развернут на Heroku.
Для подъёма iOS-приложения достаточно загрузить проект с GitHub и запустить его на двух телефонах. Так же протестировать можно с помощью веб-клиента, который имеет поле для ввода сообщения и кнопку по нажатию на которою происходит отправка сообщения. Сообщение которые получает веб-клиент выводятся в консоль. Веб-клиент доступен по ссылке: https://hidden-fjord-32367.herokuapp.com
Для разработки UI был использован статический UITableViewController, который позволяет автоматически обработать события появления и исчезания клавиатуры. Состоит из двух строк.
Первая строка содержит UITableView, который был использован для представления списка сообщений. Так же для каждого типа сообщений (отправленные и полученные сообщения) был использована собственная реализация UITableViewCell + .xib.
Вторая строка содержит UITextView, для ввода сообщения, и UIButton, по нажатию на которую отправляется сообщение.
Общая структура проекта:
	1) Models:
		- Message.swift - представляет собой модель сообщения, текст сообщения + тип сооющения (отправленное/полученное)
	2) OtherControllers:
		- SocketIOController.swift - реализация веб-сокет клиента с использованием Socket.io
	3) Views:
		- ReceiveTableViewCell.xib - реализация макета для полученного сообщения
		- SendMessageTableViewCell.xib - реализация макета для отправленного сообщения
	4) ViewControllers:
		- ChatTableViewController.swift - статический UITableViewController, содержит список сообщений (MessageHistoryTableView.swift) и панель для ввода и отправки нового сообщения
		- MessageHistoryTableView.swift - динамический UITableView, представляет собой список сообщений
		- ReceiveTableViewCell.swift - UITableViewCell, являет собой ячейку UITableView (MessageHistoryTableView.swift), которая представляет полученное сообщение
		- SendMessageTableViewCell.swift - UITableViewCell, являет собой ячейку UITableView (MessageHistoryTableView.swift), которая представляет отправленное сообщение
