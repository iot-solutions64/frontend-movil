import 'package:hydrosmart/core/global_variables.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/data/remote/irrigation_service.dart';
import 'package:hydrosmart/features/irrigation/data/remote/water_tank_request_dto.dart';
import 'package:hydrosmart/features/irrigation/data/remote/water_tank_response_dto.dart';
import 'package:hydrosmart/features/irrigation/domain/water_tank.dart';

class IrrigationRepository {

  Future<Resource<WaterTankResponseDto>> addWaterTank(String name, double capacity) async {
    WaterTankRequestDto tank = WaterTankRequestDto(
      name: name,
      maxWaterCapacity: capacity,
      userId: GlobalVariables.userId,
    );
    Resource<WaterTankResponseDto> result = await IrrigationService().addWaterTank(tank);

    if (result is Success) {
      return Success(result.data!);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<List<WaterTank>>> getWaterTanks() async {
    Resource<List<WaterTankResponseDto>> result = await IrrigationService().getWaterTanks(GlobalVariables.userId);

    if (result is Success) {
      List<WaterTank> tanks = result.data!.map((dto) => dto.toWaterTank()).toList();
      return Success(tanks);
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<WaterTank>> getWaterTank(int tankId) async {
    Resource<WaterTankResponseDto> result = await IrrigationService().getWaterTank(tankId);

    if (result is Success) {
      return Success(result.data!.toWaterTank());
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource<WaterTank>> patchName(WaterTank tank) async {
    Resource<WaterTankResponseDto> result = await IrrigationService().patchName(tank.id, tank.name);
    if (result is Success) {
      return Success(result.data!.toWaterTank());
    } 
    return Error(result.message!);
  }

  Future<Resource<WaterTank>> patchRemainingWater(WaterTank tank) async {
    Resource<WaterTankResponseDto> result = await IrrigationService().patchRemainingWater(tank.id, tank.remainingLiters);
    if (result is Success) {
      return Success(result.data!.toWaterTank());
    } 
    return Error(result.message!);
  }

  Future<Resource<WaterTank>> patchStatus(WaterTank tank) async {
    Resource<WaterTankResponseDto> result = await IrrigationService().patchStatus(tank.id, tank.status);
    if (result is Success) {
      return Success(result.data!.toWaterTank());
    } 
    return Error(result.message!);
  }

  Future<Resource> deleteWaterTank(int tankId) async {
    Resource result = await IrrigationService().deleteWaterTank(tankId);

    if (result is Success) {
      return Success(tankId);
    } else {
      return Error(result.message!);
    }
  }

}