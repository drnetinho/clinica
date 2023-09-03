const Duration oneSec = Duration(seconds: 1);
const Duration twoSec = Duration(seconds: 2);
const Duration threeSec = Duration(seconds: 3);
const Duration fiveSec = Duration(seconds: 5);
const Duration threeHundMili = Duration(milliseconds: 300);
const Duration fiveHundMili = Duration(seconds: 500);

Future<void> _sleep(Duration duration) async => await Future<void>.delayed(duration);

extension DurationSleep on Duration {
  Future<void> get sleep => _sleep(this);
}


