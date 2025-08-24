# video_play_app

Video player for playing videos

# VideoPlayer 사용 가이드

## 시작하기
- Select 화면에서 **Load a video**를 눌러 영상을 선택합니다.
- 이전/다음을 사용하려면 **사진/동영상 접근 권한**을 허용하세요. 권한이 없거나 기기에 영상이 1개뿐이면 버튼이 비활성화됩니다.

## 재생 컨트롤
- **화면 탭**: 컨트롤 표시/숨김. 재생 중엔 약 **2.6초** 후 자동으로 숨겨집니다.
- **가운데 버튼**: 재생/일시정지. 영상이 끝나면 **다시보기** 아이콘으로 바뀝니다.
- **좌우 화살표**: 이전/다음 영상으로 이동합니다. 목록의 **첫/마지막**에서는 비활성화됩니다.
- **슬라이더**: 드래그로 탐색. 좌측에 **현재/전체 시간**이 표시됩니다.

## 속도 & 제스처
- **길게 누르기**: 누르는 동안 **2배속**, 손을 떼면 **1배속**으로 복귀합니다. 상단에 배너가 표시됩니다.
- **설정(톱니)**: 고정 배속 **0.5×, 1.0×, 1.5×, 2.0×** 선택 및 **반복 재생(Loop)** 토글.

## 전체화면
- 오른쪽 하단 **전체화면** 버튼으로 가로모드 전환/해제. 가로모드에서 **뒤로가기** 시 전체화면이 먼저 해제됩니다.

## 이전/다음의 동작 원리
- 처음 선택한 영상을 기준으로 **기기 라이브러리의 최근 항목 목록**을 구성합니다.
- **중복 영상은 제거**되며, 선택한 영상의 위치를 기준으로 이전/다음이 동작합니다.
- 콘텐츠가 **1개**면 이전/다음은 비활성화됩니다.

## 문제 해결
- 컨트롤이 안 보이면 **화면을 한 번 탭**하세요.
- 이전/다음이 비활성화면: **권한 허용** 후 기기에 **영상이 여러 개** 있는지 확인하세요.
- 재생이 멈추면 **일시정지/재생** 버튼을 다시 눌러주세요.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
