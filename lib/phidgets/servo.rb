
#require 'phidgets/common'

module Phidgets

  class Servo < Common
    @@create = nil
    @@get_motor_count = nil
    @@get_position = nil
    @@set_position = nil
    @@get_position_max = nil
    @@get_position_min = nil
    @@get_servo_type = nil
    @@set_servo_type = nil
    @@get_engaged = nil
    @@set_engaged = nil
    def initialize(serial_number=-1, timeout=0)
      super()
      create
      open(serial_number, timeout) if timeout > 0
    end

    private

    def create
      @@create = sym('CPhidgetServo_create', 'Ip') if @@create == nil
      r,rs = @@create.call(@handle.ref)
      raise Phidgets::Exception.new(r) if r != 0
    end

    public

    def getMotorCount
      call_IPi(@@get_motor_count, 'CPhidgetServo_getMotorCount', @handle)
    end

    def getPosition(index)
      call_IPId(@@get_position, 'CPhidgetServo_getPosition', @handle, index)
    end
    
    def setPosition(index, position)
      puts "calling call_IXXX"
      call_IXXX(@@set_position, 'CPhidgetServo_setPosition', 'IPII', @handle, index, position)
    end
    
    def getPositionMax(index)
      call_IPId(@@get_position_max, 'CPhidgetServo_getPositionMax', @handle, index)
    end
    
    def getPositionMin(index)
      call_IPId(@@get_position_min, 'CPhidgetServo_getPositionMin', @handle, index)
    end
    
    def getEngaged(index)
      call_IPIi(@@get_engaged, 'CPhidgetServo_getEngaged', @handle, index)
    end

    def setEngaged(index, state)
      call_IXXX(@@set_engaged, 'CPhidgetServo_setEngaged', 'IPII', @handle, index, state)
    end

  end

end