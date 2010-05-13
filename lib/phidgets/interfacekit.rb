
#require 'phidgets/common'

module Phidgets

  class InterfaceKit < Common
    @@create = nil
    @@input_count = nil
    @@input_state = nil
    @@output_count = nil
    @@get_output_state = nil
    @@set_output_state = nil
    @@sensor_count = nil
    @@sensor_value = nil
    @@sensor_raw_value = nil
    @@get_ratiometric = nil
    @@set_ratiometric = nil

    def initialize(serial_number=-1, timeout=0)
      super()
      create
      open(serial_number, timeout) if timeout > 0
    end

    private

    def create
      @@create = sym('CPhidgetInterfaceKit_create', 'Ip') if @@create == nil
      r,rs = @@create.call(@handle.ref)
      raise Phidgets::Exception.new(r) if r != 0
    end

    public

    def getInputCount
      call_IPi(@@input_count, 'CPhidgetInterfaceKit_getInputCount', @handle)
    end

    def getInputState(index)
      call_IPIi(@@input_state, 'CPhidgetInterfaceKit_getInputState', @handle, index)
    end

    def getOutputCount
      call_IPi(@@output_count, 'CPhidgetInterfaceKit_getOutputCount', @handle)
    end

    def getOutputState(index)
      call_IPIi(@@get_output_state, 'CPhidgetInterfaceKit_getOutputState', @handle, index)
    end

    def setOutputState(index, state)
      call_IXXX(@@set_output_state, 'CPhidgetInterfaceKit_setOutputState', 'IPII', @handle, index, state)
    end

    def getSensorCount
      call_IPi(@@sensor_count, 'CPhidgetInterfaceKit_getSensorCount', @handle)
    end

    def getSensorValue(index)
      call_IPIi(@@sensor_value, 'CPhidgetInterfaceKit_getSensorValue', @handle, index)
    end

    def getSensorRawValue(index)
      call_IPIi(@@sensor_raw_value, 'CPhidgetInterfaceKit_getSensorRawValue', @handle, index)
    end

    def getRatiometric
      call_IPi(@@get_ratiometric, 'CPhidgetInterfaceKit_getRatiometric', @handle)
    end

    def setRatiometric(ratiometric)
      call_IXX(@@set_ratiometric, 'CPhidgetInterfaceKit_setRatiometric', 'IPI', @handle, ratiometric)
    end

  end

end

