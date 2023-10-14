
import 'package:rock_paper_scissors_game/utils/game_object.dart';
import 'package:test/test.dart';

void main(){
  group( 'GameObject',(){
    test('should initialize with correct value ', () {
      final gameObject=GameObject(type: ObjectType.Rock, x: 1, y: 2);
      expect(gameObject.type,  ObjectType.Rock);
      expect(gameObject.x, 1);
      expect(gameObject.y,2);
    });
    test('Rock Object should show R as Name', (){
      final gameObject=GameObject(type: ObjectType.Rock, x: 0, y: 0);
      expect(gameObject.getDisplayName(),"R");
    }
    );
    test('Paper Object should show P as Name', (){
      final gameObject=GameObject(type: ObjectType.Paper, x: 0, y: 0);
      expect(gameObject.getDisplayName(),"P");
    }
    );
    test('Scissor Object should show S as Name', (){
      final gameObject=GameObject(type: ObjectType.Scissors, x: 0, y: 0);
      expect(gameObject.getDisplayName(),"S");
    }
    );
    test('the value of dx, dy should be between 1,-1 ', (){
      final gameObject = GameObject(type: ObjectType.Rock, x: 0, y: 0);
      expect(gameObject.dx, isInRange(-1,1));
    });

  });
}
 Matcher isInRange(num min,num max)=>predicate<num>(
     (num value)=> value >= min && value <= max, 'is betwenn min and max'
 );