import 'dart:convert';
import 'dart:io';

import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/core/global_variables.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/data/remote/water_tank_request_dto.dart';
import 'package:hydrosmart/features/irrigation/data/remote/water_tank_response_dto.dart';
import 'package:http/http.dart' as http;

class IrrigationService {

  Future<Resource<WaterTankResponseDto>> addWaterTank(WaterTankRequestDto tank) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GlobalVariables.token}'
          },
          body: jsonEncode(tank.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final tankDto = WaterTankResponseDto.fromJson(json);
        return Success(tankDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<List<WaterTankResponseDto>>> getWaterTanks(int userId) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/user/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GlobalVariables.token}'
          },
          );
      if (response.statusCode == HttpStatus.ok) {
        dynamic jsonResponse = jsonDecode(response.body);
        List results = jsonResponse;

        List<WaterTankResponseDto> tanksDto =
            results.map((json) => WaterTankResponseDto.fromJson(json)).toList();
        return Success(tanksDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<WaterTankResponseDto>> getWaterTank(int tankId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/$tankId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final tankDto = WaterTankResponseDto.fromJson(json);
        return Success(tankDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<WaterTankResponseDto>> patchRemainingWater(int tankId, double waterAmount) async {
    try {
      http.Response response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/water-remaining'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'id': tankId,
          'waterAmount': waterAmount,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final updatedTank = WaterTankResponseDto.fromJson(json);
        return Success(updatedTank);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<WaterTankResponseDto>> patchStatus(int tankId, String status) async {
    try {
      http.Response response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/$tankId/status/$status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final updatedTank = WaterTankResponseDto.fromJson(json);
        return Success(updatedTank);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource<WaterTankResponseDto>> patchName(int tankId, String name) async {
    try {
      http.Response response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/name'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalVariables.token}'
        },
        body: jsonEncode({
          'id': tankId,
          'name': name,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final updatedTank = WaterTankResponseDto.fromJson(json);
        return Success(updatedTank);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> deleteWaterTank(int tankId) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.waterTankEndpoint}/$tankId'),
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