# MediaCollector
## Задача
Реализовать медиа-коллекцию пользователя, состоящую из ссылок и картинок. Пользователь может войти, выйти, добавить/удалить что-то в коллекции и поделиться ссылкой на коллекцию. Приложение должно быть оттестировано, используя Rspec. Все непонятные моменты можно решить на свое усмотрение и не забыть указать это в README к проекту на Github.

## Результат
[Демо](http://mediacollector.herokuapp.com/)


[![Code Climate](https://codeclimate.com/github/ilp416/mediacollector/badges/gpa.svg)](https://codeclimate.com/github/ilp416/mediacollector)
[![Travis](https://img.shields.io/travis/ilp416/mediacollector.svg?maxAge=2592000)](https://travis-ci.org/ilp416/mediacollector)


### Аунтентификация и авторизаия
Для аунтентификации использовал `devise` (хотел сперва делать аутнентификацию через социальные сети, но для расшаривания ссылок это оказалось не обязательно). Для авторизации взял `cancancan`, хотя для этого проекта он избыточен (Все могут видеть все, все могут изменять, добавлять и удалять только собственные записи). Была идея добавить тэги, но не хватило времени.

### Коллекции
Т.к. возможные типы содержимого медиа коллекции не сильно отличаются, использовал один объект `Stuff`, от которого отнаследовал `UrlStuff` для ссылок и `PictureStuff` для изображений. Для работы с загрузкой изображений использовал `paperclip` в production-окружении изображения хранятся на AWS S3 Bucket. Коллекцию можно отфильтровать по типу содержимого, а так же есть поиск, который ищет по описанию и по адресу ссылки.

#### Скриншоты url
Мне пришла идея показывать и ссылки и изображения на одной странице, но было бы странно для URL показывать пустые квадраты. Поэтому я с помощью сервиса https://screenshotmachine.com/ сделал загрузку снимков веб страниц. Что бы не заставлять пользователя ждать, т.к. получение скриншота занимает время, эту работу я запускаю в новом процессе.

### Шаринг
Для расшаривания коллекции создал объект `ShareAdapter`, через который удобно добавить новые соц.сети не изменяя код страниц.

### Rspec
Мне было непривычно использовать Rspec для интеграционного тестирования, поэтому features не покрывают полностью то, что должны. В остальном все стандартно.

Т.к. на разработку выделил не много времени, то многое еще сырое. Задача интересная и много интересного можно было бы придумать.
