

-- en el formulario de ventas rapidas, en el botón seleccionar cliente (opcional) ,
en la pantalla siguiente se selecciona el cliente, y ese objeto seleccionado en el radio button
se recupera en el screen SaleScreenGeneral, el echo es que cuando se guarda queda en base de datos
el idcliente.

SELECT * from sales s where s.client_id = '42714193-cc0e-4535-b972-6878d596a7c4'; 
// el id de la daniela

|------ notifier --------|-------                                  ----|                                                                          --|
|---SaleScreenGeneral ---|---aqui es donde guarda en la tabla sales ---|                                                                          --|
|------          --------|------ SingleChoiceListClient           -----| final selectedClientProvider = StateProvider<ThirdPart?>((ref) => null); --|


en fluter cuantos tipos diferentes de widget hay?
ConsumerStateFulWidget
ConsumeWidget
Statefulwidget
statelesswidget
en terminos de consumo de memoria es un criterio para determinar que widget utilizar, y con esto ya no hay 
necesidad de utilizar el provider, se hace un provider local entre los screen involucrados. 
me puedes explicar esto de los tipos de widget. 

filetype:pdf statelesswidget statefulwidget consumerwidget consumerstatefulwidget

