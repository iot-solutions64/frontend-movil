import 'dart:convert';
import 'dart:io';

import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/core/global_variables.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:http/http.dart' as http;
import 'package:hydrosmart/features/soil/data/remote/crop_request_dto.dart';
import 'package:hydrosmart/features/soil/data/remote/crop_response_dto.dart';

class CropService {

  Future<Resource<CropResponseDto>> addCrop(CropRequestDto tank) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GlobalVariables.token}'
          },
          body: jsonEncode(tank.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final cropDto = CropResponseDto.fromJson(json);
        return Success(cropDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<List<CropResponseDto>>> getCrops(int userId) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GlobalVariables.token}'
          },
          );
      if (response.statusCode == HttpStatus.ok) {
        dynamic jsonResponse = jsonDecode(response.body);
        List results = jsonResponse;

        List<CropResponseDto> cropsDto =
            results.map((json) => CropResponseDto.fromJson(json)).toList();
        return Success(cropsDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<CropResponseDto>> getCrop(int cropId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId/reference'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final tankDto = CropResponseDto.fromJson(json);
        return Success(tankDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> putTemperature(int cropId, double temperature, double temperatureMinThreshold, double temperatureMaxThreshold) async {
    try {
      http.Response response = await http.put(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId/temperature'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'temperature': temperature,
          'temperatureMinThreshold': temperatureMinThreshold,
          'temperatureMaxThreshold': temperatureMaxThreshold,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Success(response.body);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> patchTemperature(int cropId, double temperature) async {
    try {
      http.Response response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId/temperature'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'temperature': temperature,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Success(response.body);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> putHumidity(int cropId, double humidity, double humidityMinThreshold, double humidityMaxThreshold) async {
    try {
      http.Response response = await http.put(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId/humidity'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'humidity': humidity,
          'humidityMinThreshold': humidityMinThreshold,
          'humidityMaxThreshold': humidityMaxThreshold,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Success(response.body);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> patchHumidity(int cropId, double humidity) async {
    try {
      http.Response response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId/humidity'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'humidity': humidity,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Success(response.body);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> deleteCrop(int cropId) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.cropEndpoint}/$cropId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return Success(null);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }
    

}