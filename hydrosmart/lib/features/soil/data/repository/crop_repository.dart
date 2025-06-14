import 'package:hydrosmart/core/global_variables.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/soil/data/remote/crop_detailed_response_dto.dart';
import 'package:hydrosmart/features/soil/data/remote/crop_request_dto.dart';
import 'package:hydrosmart/features/soil/data/remote/crop_response_dto.dart';
import 'package:hydrosmart/features/soil/data/remote/crop_service.dart';
import 'package:hydrosmart/features/soil/domain/crop.dart';
import 'package:hydrosmart/features/soil/domain/crop_detailed.dart';

class CropRepository {

  Future<Resource<CropResponseDto>> addCrop(Crop crop) async {
    CropRequestDto newCrop = CropRequestDto(
      name: crop.name,
      userId: GlobalVariables.userId,
      waterTankId: crop.waterTankId,
      temperatureMinThreshold: crop.temperatureMinThreshold,
      temperatureMaxThreshold: crop.temperatureMaxThreshold,
      humidityMinThreshold: crop.humidityMinThreshold,
      humidityMaxThreshold: crop.humidityMaxThreshold,
      hourFrequency: crop.hourFrequency,
      irrigationStartDate: crop.irrigationStartDate,
      irrigationStartTime: crop.irrigationStartTime,
      irrigationDisallowedStartTime: crop.irrigationDisallowedStartTime,
      irrigationDisallowedEndTime: crop.irrigationDisallowedEndTime,
      irrigationDurationInMinutes: crop.irrigationDurationInMinutes,
      irrigationMaxWaterUsage: crop.irrigationMaxWaterUsage,
    );
    Resource<CropResponseDto> result = await CropService().addCrop(newCrop);

    if (result is Success) {
      return Success(result.data!);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<List<Crop>>> getCrops() async {
    Resource<List<CropResponseDto>> result = await CropService().getCrops(GlobalVariables.userId);

    if (result is Success) {
      List<Crop> tanks = result.data!.map((dto) => dto.toCrop()).toList();
      return Success(tanks);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<Crop>> getCrop(int cropId) async {
    Resource<CropResponseDto> result = await CropService().getCrop(cropId);

    if (result is Success) {
      return Success(result.data!.toCrop());
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<CropDetailed>> getCropDetailed(int cropId) async {
    Resource<CropDetailedResponseDto> result = await CropService().getCropDetailed(cropId);

    if (result is Success) {
      return Success(result.data!.toCropDetailed());
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource> patchTemperatureThreshold(Crop crop) async {
    Resource result = await CropService().patchTemperatureThreshold(
      crop.id,
      crop.temperatureMinThreshold,
      crop.temperatureMaxThreshold,
    );

    if (result is Success) {
      return Success(result.data!);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource> patchHumidityThreshold(Crop crop) async {
    Resource result = await CropService().patchHumidityThreshold(
      crop.id,
      crop.humidityMinThreshold,
      crop.humidityMaxThreshold,
    );

    if (result is Success) {
      return Success(result.data!);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource> deleteCrop(int cropId) async {
    Resource result = await CropService().deleteCrop(cropId);

    if (result is Success) {
      return Success(cropId);
    } else {
      return Error(result.message!);
    }
  }

}