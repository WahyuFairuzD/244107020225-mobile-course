# Week 2 – Declarative UI & Responsive Design

## Academic Overview Dashboard

This project is part of the Mobile Programming course for Week 2.
The project demonstrates declarative UI, responsive design, theme
management, accessibility, reusable widgets, AI design exploration,
and responsive widget testing using Flutter.

---

## 1. Project Overview

The application is developed as an **Academic Overview Dashboard**.

The dashboard provides an overview of academic information through
a profile header and several information cards.

The main objectives of this project are:

- Implementing declarative UI using Flutter.
- Using `Row`, `Column`, `Expanded`, and `Container`.
- Creating a responsive dashboard layout.
- Supporting narrow and wide screen layouts.
- Implementing light and dark themes.
- Providing a theme toggle.
- Adding accessibility labels.
- Creating reusable widgets.
- Testing responsive behavior.
- Exploring and evaluating alternative layouts using AI.

---

## 2. Dashboard Features

The Academic Overview Dashboard contains:

- Profile header.
- Semester information.
- Courses information.
- Assignments information.
- GPA information.
- Light theme.
- Dark theme.
- Dark mode toggle.
- Responsive layout.
- Accessibility labels.

The dashboard contains four main information cards:

| Information | Value |
|---|---:|
| Semester | 5 |
| Courses | 8 |
| Assignments | 12 |
| GPA | 3.85 |

---

## 3. Flutter Widgets Used

The application uses several standard Flutter widgets.

### Row

`Row` is used to arrange widgets horizontally.

In this project, `Row` is used in the profile header and the
theme toggle area.

### Column

`Column` is used to arrange widgets vertically.

It is used to organize the profile information and the content
inside the information cards.

### Expanded

`Expanded` is used in the profile header to allow the profile
information to occupy the remaining horizontal space.

Example:

```dart
Row(
  children: [
    CircleAvatar(
      radius: 32,
      child: Icon(Icons.person),
    ),
    SizedBox(width: 16),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Wahyu Fairuz'),
          Text('D4 Informatics Engineering'),
        ],
      ),
    ),
  ],
)