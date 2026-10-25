---
version: 1.0
name: appy-design-system
description: A quiet, Apple Notes–inspired system for a personal second-brain app. A white (or true-black) canvas, grouped inset lists, a single Notes-gold accent, and system typography. Chrome recedes so the user's own writing is the only content on screen. Built in Flutter, shipped on Android, Arabic-first with full RTL.
derived-from: D:/DESIGN.md (apple.com web analysis) — kept its ink, parchment, hairline, radius, spacing and body-type tokens; replaced the marketing components with app components; added the Notes accent, iOS system colors and dark mode.

colors:
  # Accent — the only "click me" color. Replaces Action Blue from the source file.
  accent: "#FFCC00"            # iOS systemYellow — fills: checked circles, FAB, toggles, cursor, selection
  accent-strong: "#946F00"     # darker gold for accent TEXT and thin icons on white (contrast fix)
  accent-soft: "#FFF4CC"       # selection highlight, active label chip background
  on-accent: "#1D1D1F"         # text/icon on top of accent fills (never white on yellow)

  # Surfaces
  canvas: "#FFFFFF"            # editor, chat, note pages
  canvas-grouped: "#F2F2F7"    # iOS systemGroupedBackground — list screens (Notes list, Tasks)
  surface-grouped: "#FFFFFF"   # rows/cards sitting on canvas-grouped
  surface-raised: "#F2F2F7"    # bubbles, inputs, segmented control track
  canvas-parchment: "#F5F5F7"  # kept from source — empty states, sheet backdrop tint

  # Text
  ink: "#1D1D1F"               # kept from source — all primary text
  ink-secondary: "#993C3C43"   # iOS secondaryLabel (60% alpha) — previews, dates, metadata
  ink-tertiary: "#4C3C3C43"    # iOS tertiaryLabel — placeholders, disabled
  ink-muted-48: "#7A7A7A"      # kept from source — fine print when alpha text is not possible

  # Lines
  separator: "#493C3C43"       # iOS separator — list dividers (0.5px)
  separator-opaque: "#C6C6C8"  # iOS opaqueSeparator — where content shows through
  hairline: "#E0E0E0"          # kept from source — card borders

  # Fills (iOS systemFill family) — buttons, search field, chips
  fill: "#33787880"
  fill-secondary: "#28787880"
  fill-tertiary: "#1E767680"   # search field background

  # Semantic (status only — never decorative, never a second accent)
  success: "#34C759"           # habit done, streak
  danger: "#FF3B30"            # delete, overdue, recording dot
  warning: "#FF9500"           # due today
  link: "#946F00"              # in-note links follow the accent, like Notes

  # Greys (iOS systemGrey ladder)
  grey: "#8E8E93"
  grey-2: "#AEAEB2"
  grey-3: "#C7C7CC"
  grey-4: "#D1D1D6"
  grey-5: "#E5E5EA"
  grey-6: "#F2F2F7"

colors-dark:
  accent: "#FFD60A"            # iOS systemYellow dark
  accent-strong: "#FFD60A"     # yellow already passes contrast on black
  accent-soft: "#3D3200"
  on-accent: "#1D1D1F"

  canvas: "#000000"
  canvas-grouped: "#000000"
  surface-grouped: "#1C1C1E"   # iOS secondarySystemGroupedBackground dark
  surface-raised: "#2C2C2E"    # iOS tertiarySystemGroupedBackground dark
  canvas-parchment: "#1C1C1E"

  ink: "#FFFFFF"
  ink-secondary: "#99EBEBF5"
  ink-tertiary: "#4CEBEBF5"
  ink-muted-48: "#8E8E93"

  separator: "#99545458"
  separator-opaque: "#38383A"
  hairline: "#38383A"

  fill: "#5B787880"
  fill-secondary: "#51787880"
  fill-tertiary: "#3D767680"

  success: "#30D158"
  danger: "#FF453A"
  warning: "#FF9F0A"
  link: "#FFD60A"

  grey: "#8E8E93"
  grey-2: "#636366"
  grey-3: "#48484A"
  grey-4: "#3A3A3C"
  grey-5: "#2C2C2E"
  grey-6: "#1C1C1E"

typography:
  # iOS Dynamic Type "Large" defaults. Sizes in logical px (= pt). Font stacks are for Android/Flutter.
  # latin: Inter · arabic: IBM Plex Sans Arabic (Flutter picks per-glyph via fontFamilyFallback)
  large-title:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 34px
    fontWeight: 700
    lineHeight: 1.21
    letterSpacing: -0.4px
  title-1:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 28px
    fontWeight: 700
    lineHeight: 1.21
    letterSpacing: -0.36px
  title-2:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 22px
    fontWeight: 700
    lineHeight: 1.27
    letterSpacing: -0.26px
  title-3:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 20px
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: -0.45px
  headline:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 17px
    fontWeight: 600
    lineHeight: 1.29
    letterSpacing: -0.374px
  body:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 17px
    fontWeight: 400
    lineHeight: 1.47      # kept from source — editor & chat reading pace
    letterSpacing: -0.374px
  body-compact:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 17px
    fontWeight: 400
    lineHeight: 1.29      # list rows, buttons
    letterSpacing: -0.374px
  callout:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.31
    letterSpacing: -0.32px
  subhead:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 15px
    fontWeight: 400
    lineHeight: 1.33
    letterSpacing: -0.24px
  footnote:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 13px
    fontWeight: 400
    lineHeight: 1.38
    letterSpacing: -0.08px
  footnote-strong:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 13px
    fontWeight: 600
    lineHeight: 1.38
    letterSpacing: -0.08px
  caption-1:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 12px
    fontWeight: 400
    lineHeight: 1.33
    letterSpacing: 0
  caption-2:
    fontFamily: "Inter, IBM Plex Sans Arabic"
    fontSize: 11px
    fontWeight: 400
    lineHeight: 1.18
    letterSpacing: 0.06px
  mono:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: 15px
    fontWeight: 400
    lineHeight: 1.4
    letterSpacing: 0

  # Note editor paragraph styles — mirror Apple Notes' Format menu
  note-title:       "{typography.title-1}"
  note-heading:     "{typography.title-2}"
  note-subheading:  "{typography.title-3}"
  note-body:        "{typography.body}"
  note-monostyled:  "{typography.mono}"

rounded:
  none: 0px
  xs: 5px          # kept — inline code, small badges
  sm: 8px          # kept — inline images in notes, thumbnails
  md: 10px         # inset grouped lists, search field, chat input, cards (iOS standard)
  lg: 18px         # kept — chat bubbles, kanban cards
  sheet: 14px      # top corners of bottom sheets
  pill: 9999px     # chips, segmented control thumb, send button
  full: 9999px     # circular buttons, checklist circles, avatars

spacing:
  xxs: 4px
  xs: 8px
  sm: 12px
  md: 16px         # screen side margin & inset-list margin (iOS uses 16, not the source's 17)
  lg: 24px
  xl: 32px
  xxl: 48px

sizes:
  touch-min: 44px
  nav-bar: 44px
  large-title-bar: 52px      # added below nav-bar when large title is expanded
  tab-bar: 56px              # + bottom system inset; slightly taller than iOS 49 for Android gesture bar
  toolbar: 44px
  list-row-min: 44px
  note-row: 64px             # title line + date/preview line
  search-field: 36px
  checklist-circle: 22px
  icon: 22px
  icon-small: 17px
  fab: 52px
  sheet-grabber: "36x5px"

motion:
  press: "scale(0.97), 100ms"          # source used 0.95 for web buttons; 0.97 for list rows/cards
  standard: "250ms, Curves.easeInOutCubic"
  sheet: "350ms, spring (damping 0.86)"
  large-title-collapse: "scroll-linked, no duration"

components:
  # ── Chrome ─────────────────────────────────────────
  nav-bar:
    backgroundColor: "{colors.canvas} @ 80% + blur(20)"   # frosted, kept from source sub-nav
    textColor: "{colors.ink}"
    typography: "{typography.headline}"
    height: "{sizes.nav-bar}"
    actionColor: "{colors.accent-strong}"
  large-title:
    typography: "{typography.large-title}"
    textColor: "{colors.ink}"
    padding: 0 16px 8px
  tab-bar:
    backgroundColor: "{colors.canvas} @ 80% + blur(20)"
    borderTop: "0.5px {colors.separator}"
    height: "{sizes.tab-bar}"
    itemSelected: "{colors.accent-strong}"
    itemIdle: "{colors.grey}"
    labelTypography: "{typography.caption-2}"
    items: [Chat, Notes, Tasks]
  toolbar-bottom:
    backgroundColor: "{colors.canvas} @ 80% + blur(20)"
    height: "{sizes.toolbar}"
    iconColor: "{colors.accent-strong}"
  search-field:
    backgroundColor: "{colors.fill-tertiary}"
    textColor: "{colors.ink}"
    placeholderColor: "{colors.ink-secondary}"
    typography: "{typography.body-compact}"
    rounded: "{rounded.md}"
    height: "{sizes.search-field}"
    padding: 0 8px
  segmented-control:
    trackColor: "{colors.fill-tertiary}"
    thumbColor: "{colors.surface-grouped}"
    typography: "{typography.footnote-strong}"
    rounded: "{rounded.md}"
    height: 32px

  # ── Lists ──────────────────────────────────────────
  inset-group:
    backgroundColor: "{colors.surface-grouped}"
    pageColor: "{colors.canvas-grouped}"
    rounded: "{rounded.md}"
    margin: 0 16px
    dividerColor: "{colors.separator}"
    dividerInset: 16px
  section-header:
    typography: "{typography.title-3}"
    textColor: "{colors.ink}"
    padding: 20px 16px 8px
  note-row:
    height: "{sizes.note-row}"
    titleTypography: "{typography.headline}"
    metaTypography: "{typography.subhead}"     # "10:42 PM  first line of body…"
    metaColor: "{colors.ink-secondary}"
    padding: 10px 16px
    trailing: optional thumbnail 44x44 @ {rounded.sm}
  swipe-actions:
    pin: "{colors.accent}"
    move: "{colors.grey}"
    delete: "{colors.danger}"

  # ── Buttons ────────────────────────────────────────
  button-primary:
    backgroundColor: "{colors.accent}"
    textColor: "{colors.on-accent}"
    typography: "{typography.headline}"
    rounded: "{rounded.md}"
    height: 50px
  button-plain:
    backgroundColor: transparent
    textColor: "{colors.accent-strong}"
    typography: "{typography.body-compact}"
  button-tinted:
    backgroundColor: "{colors.accent-soft}"
    textColor: "{colors.accent-strong}"
    typography: "{typography.subhead}"
    rounded: "{rounded.pill}"
    padding: 6px 14px
  button-icon-circular:
    backgroundColor: "{colors.fill-tertiary}"
    iconColor: "{colors.ink}"
    rounded: "{rounded.full}"
    size: "{sizes.touch-min}"
  fab-compose:
    backgroundColor: transparent
    icon: square.and.pencil
    iconColor: "{colors.accent-strong}"
    size: "{sizes.touch-min}"
    placement: bottom toolbar, trailing   # Notes puts compose in the toolbar, not a floating circle

  # ── Note editor ────────────────────────────────────
  note-editor:
    backgroundColor: "{colors.canvas}"
    padding: 8px 16px
    cursorColor: "{colors.accent}"
    selectionColor: "{colors.accent-soft}"
    firstLineStyle: "{typography.note-title}"   # first line auto-becomes Title, like Notes
    dateStampTypography: "{typography.footnote}"
    dateStampColor: "{colors.ink-secondary}"
  editor-toolbar:      # sits above keyboard
    backgroundColor: "{colors.canvas-parchment} @ 90% + blur(20)"
    height: "{sizes.toolbar}"
    items: [Aa format, checklist, table?, attach (camera/photo), record audio, ai-assist]
    iconColor: "{colors.ink}"
    iconActive: "{colors.accent-strong}"
  format-sheet:
    styles: [Title, Heading, Subheading, Body, Monostyled]
    inline: [Bold, Italic, Underline, Strikethrough]
    lists: [bulleted, dashed, numbered, block-quote]
  checklist-item:
    circleSize: "{sizes.checklist-circle}"
    circleBorder: "1.5px {colors.grey-3}"
    circleChecked: "{colors.accent} fill + white check"
    checkedText: "{colors.ink-secondary}"   # Notes does NOT strike through by default
    gap: 10px
  inline-image:
    rounded: "{rounded.sm}"
    maxWidth: 100%
    margin: 8px 0
  audio-attachment:
    backgroundColor: "{colors.surface-raised}"
    rounded: "{rounded.md}"
    padding: 12px
    height: 64px
    contents: [play button (accent), waveform (grey-3 → accent as it plays), duration (footnote, ink-secondary)]
    transcript: collapsible "Transcript" row under the card, {typography.subhead}
  recording-sheet:
    backgroundColor: "{colors.surface-grouped}"
    rounded: "{rounded.sheet} top"
    waveformColor: "{colors.danger}"
    timerTypography: "{typography.title-1}"   # tabular figures
    stopButton: "64px circle, {colors.danger}"
  label-chip:
    backgroundColor: "{colors.fill-tertiary}"
    textColor: "{colors.ink-secondary}"
    typography: "{typography.footnote}"
    rounded: "{rounded.pill}"
    padding: 4px 10px
    prefix: "#"                               # Notes-style tag
  label-chip-ai-suggested:
    border: "1px dashed {colors.accent-strong}"
    textColor: "{colors.accent-strong}"       # tap to accept, long-press to reject
  linked-note-row:
    icon: link
    typography: "{typography.subhead}"
    textColor: "{colors.link}"

  # ── AI ─────────────────────────────────────────────
  ai-assist-sheet:      # the "AI sidebar" inside the editor — a bottom sheet on mobile
    backgroundColor: "{colors.surface-grouped}"
    rounded: "{rounded.sheet} top"
    grabber: "{sizes.sheet-grabber} {colors.grey-3}"
    detents: [40%, 90%]
    contextBadge: "about: <current note title>" in {component.label-chip}
  chat-screen:
    backgroundColor: "{colors.canvas}"
    emptyState: centered greeting in {typography.title-2} + 2–3 {component.suggestion-chip}
  chat-bubble-user:
    backgroundColor: "{colors.surface-raised}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.lg}"
    padding: 10px 14px
    maxWidth: 80%
    align: end           # end = left in RTL, right in LTR
  chat-message-assistant:
    backgroundColor: transparent   # assistant answers are plain text, no bubble
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    padding: 4px 0
  source-citation:      # every factual claim links to the note it came from
    backgroundColor: "{colors.accent-soft}"
    textColor: "{colors.accent-strong}"
    typography: "{typography.caption-1}"
    rounded: "{rounded.xs}"
    padding: 1px 6px
    format: "[1]" inline → tap opens note
  sources-list:
    typography: "{typography.footnote}"
    rowIcon: doc.text
    divider: "{colors.separator}"
  no-answer-state:
    typography: "{typography.body}"
    textColor: "{colors.ink-secondary}"
    copy: "مش لاقي حاجة عن ده في ملاحظاتك."
    action: "{component.button-tinted} 'ابحث على النت'"   # web search only after this tap
  capture-confirmation-card:   # shown when chat input is saved as a note/task/expense
    backgroundColor: "{colors.surface-grouped}"
    border: "0.5px {colors.separator}"
    rounded: "{rounded.md}"
    padding: 12px
    title: "{typography.footnote-strong}"  # "اتسجل في المصاريف"
    body: "{typography.subhead}"           # "150 ج · مواصلات · النهارده"
    actions: [Edit, Undo] as {component.button-plain}
  web-search-toggle:
    idle: "{colors.fill-tertiary} globe icon, {colors.grey}"
    active: "{colors.accent-soft} globe icon, {colors.accent-strong} + 'Web' label"
  suggestion-chip:
    backgroundColor: "{colors.fill-tertiary}"
    textColor: "{colors.ink}"
    typography: "{typography.subhead}"
    rounded: "{rounded.pill}"
    padding: 8px 14px
  chat-composer:
    backgroundColor: "{colors.canvas} @ 80% + blur(20)"
    fieldColor: "{colors.surface-raised}"
    fieldRounded: "{rounded.lg}"
    typography: "{typography.body}"
    minHeight: 36px
    maxLines: 6
    leading: [attach, web-search-toggle]
    trailing: "mic when empty → send (32px circle, {colors.accent}, arrow.up in {colors.on-accent}) when typing"

  # ── Tasks ──────────────────────────────────────────
  view-switcher:
    component: "{component.segmented-control}"
    options: [List, Calendar, Board]
  task-row:
    height: "{sizes.list-row-min}"
    leading: "{component.checklist-item} circle"
    titleTypography: "{typography.body-compact}"
    metaTypography: "{typography.footnote}"   # due date, label
    metaColor: "{colors.ink-secondary}"
    overdueColor: "{colors.danger}"
    dueTodayColor: "{colors.warning}"
  habit-row:
    height: 56px
    leading: "circle, fills {colors.success} when done today"
    titleTypography: "{typography.body-compact}"
    trailing: "streak — flame icon + number, {typography.footnote-strong}"
    weekStrip: "7 dots × 6px, done = {colors.success}, missed = {colors.grey-4}"
  calendar-day-cell:
    size: 44px
    typography: "{typography.body-compact}"
    today: "{colors.accent} circle, {colors.on-accent} text"
    selected: "{colors.ink} circle, {colors.canvas} text"
    eventDot: "4px, {colors.grey} (habit = {colors.success})"
  kanban-column:          # tasks only — habits never appear on the board
    backgroundColor: "{colors.canvas-grouped}"
    width: 280px
    header: "{typography.headline} + count in {typography.footnote} {colors.ink-secondary}"
    columns: [To do, Doing, Done]
  kanban-card:
    backgroundColor: "{colors.surface-grouped}"
    rounded: "{rounded.md}"
    padding: 12px
    titleTypography: "{typography.subhead}"
    dragState: "scale(1.03) + shadow 0 8px 24px rgba(0,0,0,0.12)"   # only shadow in the app UI
---

## Overview

appy looks and behaves like Apple Notes, then adds a chat that answers only from the user's own notes. The design rule is simple: **the user's words are the only content.** No dashboards, no charts on a home screen, no decorative color. Chrome is white (or true black), frosted bars float over content, and one gold accent marks everything tappable.

The app has three tabs:

`Chat → ask / capture` · `Notes → write` · `Tasks → do`

**Key characteristics**
- Single accent: Notes gold (`{colors.accent}`). It replaces the source file's Action Blue. Blue does not appear anywhere.
- Two canvas modes: plain white `{colors.canvas}` for reading/writing screens (Chat, editor), grouped grey `{colors.canvas-grouped}` with white inset rows for list screens (Notes list, Tasks).
- iOS type scale (Large Title 34 → Caption 2 11), body at 17px with 1.47 leading for long reading.
- No shadows in the app chrome. Depth comes from frosted blur bars and surface-color steps. One exception: a dragged kanban card.
- Arabic-first, full RTL. Every layout uses `start/end`, never `left/right`.
- Honesty is a visual feature: AI answers carry citations, AI-suggested labels look visibly different (dashed) until the user accepts them, and "no answer" is a designed state, not an error.

## Colors

All values are the real iOS system colors, taken from Flutter's `CupertinoColors` source (`packages/flutter/lib/src/cupertino/colors.dart`), so light and dark match iOS exactly. Alpha colors are written `#AARRGGBB`.

### Accent
- **Notes Gold** (`{colors.accent}` — #FFCC00 / dark #FFD60A): iOS `systemYellow`. Apple Notes' tint is the system yellow accent. Used as a **fill**: checked checklist circles, the send button, today in the calendar, the cursor, toggles.
- **Gold Strong** (`{colors.accent-strong}` — #946F00): Yellow text on white fails contrast (≈1.6:1). Any accent that is **text or a thin icon** on a light surface uses this darker gold instead. In dark mode it is the same as `accent`, since yellow on black passes easily. *#946F00 gives ≈4.6:1 on white (WCAG AA). It is a contrast-driven choice, not a sampled Apple value; the earlier #C79500 was only ≈2.7:1.*
- **Gold Soft** (`{colors.accent-soft}`): text selection, accepted label chips, citation badges.
- **On Accent** (`{colors.on-accent}` — #1D1D1F): text on yellow is always near-black, never white.

### Surfaces
- `{colors.canvas}` white / black: Chat, note editor.
- `{colors.canvas-grouped}` #F2F2F7 / black: Notes list, Tasks. Rows sit on it in `{colors.surface-grouped}` (white / #1C1C1E).
- `{colors.surface-raised}` #F2F2F7 / #2C2C2E: user chat bubbles, audio cards, input fields.
- Dark mode uses **true black** for the canvas like iOS (and saves battery on OLED Android phones). Raised surfaces step up through #1C1C1E → #2C2C2E.

### Text
- `{colors.ink}` #1D1D1F: kept from the source file, all primary text.
- `{colors.ink-secondary}`: 60% alpha. Note previews, timestamps, metadata.
- `{colors.ink-tertiary}`: 30% alpha. Placeholders ("ابدأ الكتابة…"), disabled.

### Semantic
`success`, `danger`, `warning` are status signals only: habit done, overdue/delete/recording, due today. They never style a button that isn't about that status.

## Typography

### Fonts (Android)
SF Pro and SF Arabic are licensed for Apple platforms only, so they cannot ship in an Android app.

| Script | Font | Why |
|---|---|---|
| Latin | **Inter** | Closest open match to SF Pro (the source file recommends it too) |
| Arabic | **IBM Plex Sans Arabic** | Clean, neutral, has 400/600/700, pairs well with Inter's x-height |
| Mono | **JetBrains Mono** | Monostyled paragraphs in notes |

In Flutter: `fontFamily: 'Inter'`, `fontFamilyFallback: ['IBM Plex Sans Arabic']`. Mixed lines like "اجتماع مع Ahmed الساعة 5" render each script in its own font automatically.

Arabic needs taller line boxes than Latin. Never go below 1.29 line-height on any style that can hold Arabic. Never apply negative letter-spacing to Arabic runs (it breaks letter joining). If a text widget is known to be Arabic, set `letterSpacing: 0`.

### Scale
| Token | Size | Weight | Use |
|---|---|---|---|
| `large-title` | 34 | 700 | Screen titles (Notes, Tasks), collapses on scroll |
| `title-1` | 28 | 700 | Note Title style, recording timer |
| `title-2` | 22 | 700 | Note Heading style, chat empty-state greeting |
| `title-3` | 20 | 600 | Note Subheading style, list section headers |
| `headline` | 17 | 600 | Note row titles, nav bar titles, primary buttons |
| `body` | 17 | 400 | Editor & chat text (1.47 leading) |
| `body-compact` | 17 | 400 | List rows, task rows (1.29 leading) |
| `subhead` | 15 | 400 | Note row date + preview, chips |
| `footnote` | 13 | 400 | Metadata, labels, timestamps |
| `caption-1/2` | 12/11 | 400 | Citations, tab bar labels |

Weight ladder is 400 / 600 / 700. No 500 (rule kept from the source file).

## Layout

- **Base unit 8px.** Screen side margin is 16px (iOS standard; the source's 17px is web).
- **Inset grouped lists:** 16px from screen edges, `{rounded.md}` 10px corners, 0.5px separators inset 16px from the start edge.
- **Editor:** full-width white, 16px side padding, no max width on phones.
- **Chat:** messages full-width with 16px padding. User bubbles max 80% width, aligned to `end`.
- **Bottom stacking order:** content → frosted composer/toolbar → tab bar → system gesture inset. The tab bar hides while the keyboard is open in the editor and in chat.

## Elevation & Depth

| Level | Treatment | Use |
|---|---|---|
| Flat | none | Canvas, rows, bubbles |
| Hairline | 0.5px `{colors.separator}` | List dividers, tab bar top edge, capture card |
| Frosted | canvas @ 80% + `blur(20)` | Nav bar, tab bar, editor toolbar, chat composer |
| Sheet | `{colors.surface-grouped}`, 14px top radius, dimmed backdrop `rgba(0,0,0,0.3)` | AI assist sheet, recording sheet, format sheet |
| Lifted | `0 8px 24px rgba(0,0,0,0.12)` | Dragged kanban card only |

The source file's single product shadow is not used. There is no product photography in this app.

## Shapes

| Token | Value | Use |
|---|---|---|
| `xs` | 5 | Citation badge, inline code |
| `sm` | 8 | Images inside notes, row thumbnails |
| `md` | 10 | Inset lists, search field, cards, audio attachment, primary button |
| `lg` | 18 | Chat bubbles, composer field |
| `sheet` | 14 | Bottom sheet top corners |
| `pill` / `full` | 9999 | Chips, send button, checklist circles, segmented thumb |

## Components — by screen

### 1. Chat (tab 1, opens first)
- Empty state: white screen, greeting in `title-2` centred slightly above middle, 2–3 `suggestion-chip`s ("مهام النهارده", "صرفت كام الأسبوع ده؟"). Nothing else. No numbers until asked.
- `chat-composer` at the bottom: attach + `web-search-toggle` on the start side, mic morphs into the gold send button once text exists.
- Answers: plain text with inline `source-citation` badges `[1]`, then a compact `sources-list`. A claim without a source is a bug.
- `no-answer-state` when retrieval finds nothing: says so plainly and offers a tinted "ابحث على النت" button. Web search runs **only** after that tap or when `web-search-toggle` is on.
- Capture: when a message is information rather than a question ("دفعت 150 بنزين"), reply with a `capture-confirmation-card` with Edit / Undo.

### 2. Notes (tab 2)
- **List:** `large-title` "Notes" + `search-field` on `canvas-grouped`. Sections "Pinned", "Today", "Previous 7 Days", "Previous 30 Days", then by month (Notes' own grouping). Each item is a `note-row` in an `inset-group`. Compose icon in the bottom toolbar on the end side.
- **Editor:** white canvas, date stamp centred at the top in `footnote`, first line auto-styled `note-title`. `editor-toolbar` floats above the keyboard: Aa · checklist · camera/photo · record · ✦ AI.
- **Attachments:** images inline at full width with `{rounded.sm}`. Audio as `audio-attachment` with a collapsible transcript underneath.
- **After save:** labels appear at the bottom of the note as `label-chip`s. AI suggestions stay in dashed `label-chip-ai-suggested` style until accepted. Related notes appear as `linked-note-row`s under a "Related" header.
- **AI assist:** ✦ opens `ai-assist-sheet` at 40% height, scoped to the current note (context badge shows which). Drag to 90% for a longer conversation.

### 3. Tasks (tab 3)
- `large-title` "Tasks" + `view-switcher` (List · Calendar · Board).
- **List:** two `inset-group`s: "Habits" (`habit-row`, with the week strip and streak) and "Tasks" (`task-row`, grouped Today / Upcoming / No date).
- **Calendar:** month grid of `calendar-day-cell`s, with that day's habits and tasks listed below.
- **Board:** horizontal scroll of `kanban-column`s, tasks only. Habits have no stages, so they never appear here.

## Interaction States

- **Pressed:** rows and cards `scale(0.97)` + background to `{colors.fill-tertiary}` for 100ms. Buttons drop to 70% opacity (iOS behaviour, rather than the source file's web scale).
- **Focus (keyboard/accessibility):** 2px `{colors.accent-strong}` outline, `{rounded.md}`.
- **Disabled:** `{colors.ink-tertiary}` text, no fill change.
- **Loading (AI working):** three-dot pulse in `{colors.grey}` where the answer will appear. No spinners in chrome.
- **Syncing to Notion:** a tiny `cloud` icon in the note's date stamp. Grey = pending, hidden = synced, `{colors.danger}` = failed (tap to retry). Sync state should never block writing.
- **Haptics:** light impact on checklist toggle and habit done, medium on recording start/stop.

## RTL & Bilingual Rules

1. The app runs RTL by default (`Directionality: rtl`). The Latin-only parts (code, URLs) run in their own LTR spans.
2. Use `EdgeInsetsDirectional`, `AlignmentDirectional`, `start/end` everywhere. Search the codebase for `left:` / `right:`: each one is a bug.
3. Each paragraph's direction comes from its first strong character, so a note can mix an English paragraph with Arabic ones. Use `TextDirection` detection per paragraph in the editor, not app-wide.
4. Mirror directional icons (back chevron, send arrow, swipe directions). Don't mirror the clock, media play, or checkmarks.
5. Numbers: show Western digits (0–9) by default for amounts and dates, so currency and dates stay consistent with Notion. Make it a single setting, not per-screen.

## Do's and Don'ts

### Do
- Use `{colors.accent}` for fills and `{colors.accent-strong}` for accent text on light surfaces. Every tappable thing is gold or ink.
- Put list screens on `canvas-grouped` with white inset rows. Put reading/writing screens on plain `canvas`.
- Keep the chat empty state empty. The user asks, the app answers.
- Show where every AI answer came from. Show AI-suggested labels as suggestions until the user accepts.
- Use `0.5px` separators. Thicker lines look Android-default, not Apple.
- Respect system text scaling. Every size here is a default, not a fixed size.

### Don't
- Don't use blue anywhere. It is the source file's accent, not this app's.
- Don't put white text on yellow.
- Don't add dashboards, charts or counters to a screen the user didn't ask about.
- Don't use Material ripples. Use the pressed-state fill + scale instead (`splashFactory: NoSplash.splashFactory`).
- Don't use shadows on cards, rows or bubbles.
- Don't use negative letter-spacing on Arabic text.
- Don't use `left`/`right` in layout code.

## Flutter Implementation Notes

- Build on `CupertinoApp`, or on `MaterialApp` with a custom `ThemeData` that kills Material defaults. Cupertino widgets (`CupertinoSliverNavigationBar` for the collapsing large title, `CupertinoSearchTextField`, `CupertinoSlidingSegmentedControl`, `CupertinoListSection.insetGrouped`) already match most components above on Android too.
- Map `colors` / `colors-dark` to one `ThemeExtension<AppColors>` with `lerp` for smooth theme switching. Prefer `CupertinoDynamicColor` where a Cupertino widget takes a color.
- Fonts via `google_fonts` (Inter, IBM Plex Sans Arabic, JetBrains Mono) or bundled assets. Bundling avoids a first-launch network fetch.
- Frosted bars: `ClipRect` + `BackdropFilter(ImageFilter.blur(sigmaX: 20, sigmaY: 20))` over `canvas.withOpacity(0.8)`.
- Turn off overscroll glow: `ScrollConfiguration` with `BouncingScrollPhysics` to get iOS-style bounce.

## Known Gaps

- **Notes' exact gold:** Apple doesn't publish a separate Notes tint. It follows the system accent. `systemYellow` is used as the base, and `accent-strong` is a contrast fix chosen by hand. Verify both on a real Android screen next to an iPhone screenshot.
- **Rich-text editor package not chosen yet.** Components above describe the look. Whether `super_editor`, `fleather` or `appflowy_editor` can render the checklist circle and audio card exactly needs a spike, with RTL as the first test.
- **iPad/tablet layouts** (Notes' three-column split view) are out of scope: mobile only.
- **High-contrast colour variants** exist in `CupertinoColors` but aren't listed here. Add them if accessibility testing asks for it.

## Sources

- Base tokens: `D:/DESIGN.md` (apple.com analysis)
- iOS system colours (light/dark): [Flutter `CupertinoColors` source](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/colors.dart) · [CupertinoColors API](https://api.flutter.dev/flutter/cupertino/CupertinoColors-class.html) · [Apple UI element colors](https://developer.apple.com/tutorials/data/documentation/uikit/ui-element-colors.md)
- Type scale: [Apple HIG — Typography](https://developer.apple.com/design/human-interface-guidelines/typography)
- Notes accent behaviour: [MacMost — accent colour in Apple apps](https://macmost.com/changing-the-accent-color-used-in-apple-apps.html) · [Gadget Hacks — yellow links in Notes](https://ios.gadgethacks.com/how-to/sick-yellow-links-notes-make-them-any-color-you-want-with-these-hidden-iphone-ipad-and-mac-settings-0385154/)
