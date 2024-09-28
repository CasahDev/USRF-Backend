import 'package:dart_frog/dart_frog.dart';

mixin IUserDAO {
  /// Create a user
  ///
  /// [data] is the data of the user
  ///
  /// Returns a response with the message 'User succesfly created' and the status code [200] if the user is created
  ///
  /// Returns a response with the message 'User could not be created (error: $e)' and the status code [500] if the user could not be created
  Future<Response> createUser(Map<String, dynamic> data);

  /// Get all users
  ///
  /// Returns a response with the message 'Users found' and the status code [200] if the users are found
  ///
  /// Returns a response with the message 'Users not found' and the status code [500] if no users are not found
  Future<Response> getUsers();

  /// Get a user by id
  ///
  /// [id] is the id of the user
  ///
  /// Returns a response with the message 'User found' and the status code [200] if the user is found
  ///
  /// Returns a response with the message 'User not found' and the status code [404] if the user is not found
  Future<Response> getUserById(int id);

  /// Update a user
  ///
  /// [id] is the id of the user
  ///
  /// [data] is the data of the user
  ///
  /// Returns a response with the message 'User updated' and the status code [200] if the user is updated
  ///
  /// Returns a response with the message 'User not found' and the status code [404] if the user is not found
  ///
  /// Returns a response with the message 'User could not be updated (error: $e)' and the status code [500] if the user could not be updated
  Future<Response> updateUser(int id, Map<String, dynamic> data);

  /// Delete a user
  ///
  /// [id] is the id of the user
  ///
  /// Returns a response with the message 'User deleted' and the status code [200] if the user is deleted
  ///
  /// Returns a response with the message 'User not found' and the status code [404] if the user is not found
  ///
  /// Returns a response with the message 'User could not be deleted (error: $e)' and the status code [500] if the user could not be deleted
  Future<Response> deleteUser(int id);

  /// Login to an account
  ///
  /// [data] is the data of the user
  ///
  /// Returns a response with the message 'User logged in' and the status code [200] if the user is logged in
  ///
  /// Returns a response with the message 'User not found' and the status code [404] if the user is not found
  ///
  /// Returns a response with the message 'Password is incorrect' and the status code [401] if the password is incorrect
  ///
  /// Returns a response with the message 'User could not be logged in (error: $e)' and the status code [500] if the user could not be logged in
  Future<Response> login(String data);
  }
