


import 'package:go_router/go_router.dart';

import 'component/custom_transitions.dart';


final GoRouter router = GoRouter(
  initialLocation: RoutePath.splash,
    routes: [],
  observers: [
    GoRouterObserver()
  ]
);






class RoutePath {
  static const String home = '/home';

  static const String splash = '/splash';

  static const String login = '/login';

  static const String loginProcess = '/loginProcess';

  static const String addQuestion = '/addQuestion';

  static const String postDetail = '/postDetail';

  static const String modifyUser = '/modifyUser';

  static const String myWritePost = '/myWritePost';

  static const String setting = '/setting';

  static const manager = '/manager';

  static const productDetail = '/productDetail';

  static const oakBottle = '/oakBottle';

  static const bestRecipe = '/bestRecipe';

  static const userFaq = '/userFaq';

  static const userFaqDetail = '/userFaqDetail';

  static const encyclopedia = '/encyclopedia';

  static const addAlcoholic = '/addAlcoholic';

  static const addMyOakBottle = '/addMyOakBottle';

  static const myOakBottleDetail = '/myOakBottleDetail';

  static const myCalculator = '/myCalculator';

  static const fullScreen = '/fullScreen';

  static const addProduct = '/addProduct';

  static const askOrBug = '/askOrBug';

  static const checkUserAsk = '/checkUserAsk';

  static const userAskDetail = '/userAskDetail';

  static const myAsk = '/myAsk';

  static const myAskDetail = '/myAskDetail';

  static const useOakStick = '/useOakStick';

  static const myOakRipening = '/myOakRipening';

  static const addMyRipening = '/addMyRipening';

  static const addRipeningMemo = '/addRipeningMemo';

  static const oakRipeningNumber = '/oakRipeningNumber';

  static const userManage = '/userManage';

  static const addHomeImage = '/addHomeImage';
  
  static const ripeningMemoDetail = '/ripeningMemoDetail';

  static const modifyMyOak = '/modifyMyOak';

  static const favoritePost = '/favoritePost';

  static const modifyProduct = '/modifyProduct';

  static const modifyProductInfo = '/modifyProductInfo';

  static const addFaq = '/addFaq';

  static const modifyPost = '/modifyPost';

  static const modifyRipening = '/modifyRipening';

  static const reportCommunity = '/reportCommunity';

  static const blockedUser = '/blockedUser';

  static const addDistillation = '/addDistillation';

  static const distillationResult = '/distillationResult';

  static const myDistillationDetail = '/myDistillationDetail';
}