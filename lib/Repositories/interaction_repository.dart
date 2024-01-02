import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Models/user_interaction.dart';
import 'package:soiscan/Repositories/dio_exception.dart';
import 'package:soiscan/Resources/interaction_resource.dart';

class InteractionRepository {
  final InteractionResource _interactionResource = InteractionResource();
  Future<User> getInteractedUser(String userID) async {
    try {
      final Response response = await _interactionResource.getUserByUserID(userID);
      final User user = User.fromJson(response.data['data']);
      return user;
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString());
    }
  }
  
  Future<void> interactWithOtherUser(int nik, double latitude, double longitude) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String accessToken = prefs.getString("access_token")!;
      await _interactionResource.interactWithOtherUser(accessToken, nik, latitude, longitude);
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString()); 
    }
  }

  Future<List<UserInteraction>> getInteractionsHistory() async {
    try {
      // Get Access Token
      final prefs = await SharedPreferences.getInstance();
      final String accessToken = prefs.getString("access_token")!;
      
      // Get User Interactions History from API
      final Response response = await _interactionResource.getInteractionsHistory(accessToken);
      final data = response.data['data'];
      List<UserInteraction> interactions = [];

      // Loop interactions data and turn to UserInteraction Object
      for (var element in data) {
        final UserInteraction interaction = UserInteraction.fromJson(element);
        interactions.add(interaction);
      }

      // return User Interactions History
      return List.from(interactions.reversed);
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString()); 
    }
  }

}