# Rick and Morty

iOS-приложение — справочник по вселенной *Рик и Морти*. Показывает персонажей, локации и эпизоды на основе публичного [Rick and Morty API](https://rickandmortyapi.com/).

## Основные возможности

- **Персонажи** — каталог с пагинацией и детальной карточкой (статус, вид, пол, происхождение, локация, список эпизодов)
- **Локации** — экран деталей локации с типом, измерением и списком жителей
- **Эпизоды** — экран деталей эпизода с названием, кодом серии, датой выхода и списком персонажей
- **Навигация** — переходы между связанными сущностями (персонаж → локация/эпизод и обратно)
- **Загрузка изображений** — аватары персонажей через `URLSession` и операции загрузки

## Архитектура

Проект построен на **Clean Swift (VIP)**: ViewController → Interactor → Presenter, плюс Router, Worker и Module-сборка.

| Слой | Роль |
|------|------|
| **ViewController** | UI, передача пользовательских действий в Interactor |
| **Interactor** | Бизнес-логика, запросы данных через Worker |
| **Presenter** | Подготовка view models для экрана |
| **Router** | Навигация между сценами |
| **Worker** | Работа с сетевым слоем / API |
| **Module** | Сборка зависимостей сцены |

Сцены:

- `MainScene` — список персонажей
- `CharacterDetailScene` — детали персонажа
- `LocationDetailScene` — детали локации
- `EpisodeDetailScene` — детали эпизода

Переиспользуемые UI-компоненты: `Avatar`, `Character`, `Description`, `Episode`.

## Структура проекта

```
RickAndMorty/
├── App/                    # AppDelegate, SceneDelegate
├── Scenes/                 # Экраны (VIP-модули)
├── Components/             # Ячейки и view models
├── NetworkLayer/
│   ├── DataSourceEndpoints # Эндпоинты API
│   ├── DataSourceRemote    # Удалённый data source
│   ├── DTO/                # Модели ответа API
│   ├── Models/             # HTTP-типы, ошибки, параметры
│   └── NetwrokAuth/        # URLSession, request builder, APIManager
└── Resources/
    ├── Assets.xcassets
    └── Tools/              # Базовые VC, секции, загрузка изображений
```

## Технологии

- **Swift 5**
- **UIKit** (программная сборка UI, без Storyboard как точки входа)
- **URLSession** — сетевые запросы
- **Clean Swift (VIP)** — архитектура экранов
- **Codable** — парсинг JSON

## API

Базовый URL: `https://rickandmortyapi.com`

Используемые эндпоинты:

| Ресурс | Путь |
|--------|------|
| Персонаж / список | `/api/character/{id}`, `/api/character?page=` |
| Локация / список | `/api/location/{id}`, `/api/location?page=` |
| Эпизод / список | `/api/episode/{id}`, `/api/episode?page=` |

Документация API: [rickandmortyapi.com/documentation](https://rickandmortyapi.com/documentation)

## Требования

- Xcode 16+
- iOS 16.6+
- macOS с поддержкой симулятора или физического устройства

## Запуск

1. Клонируйте репозиторий
2. Откройте `RickAndMorty.xcodeproj` в Xcode
3. Выберите симулятор или устройство
4. Нажмите **Run** (`⌘R`)

Интернет обязателен: данные загружаются с публичного API без ключа доступа.
