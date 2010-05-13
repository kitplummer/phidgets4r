
#require 'phidgets/common'

module Phidgets

  class RFID < Common
    @@create = nil
    @@output_count = nil
    @@get_output_state = nil
    @@set_output_state = nil
    @@get_antenna_on = nil
    @@set_antenna_on = nil
    @@get_led_on = nil
    @@set_led_on = nil
    @@get_last_tag = nil
    @@get_tag_status = nil
    @@on_tag_handler = nil
    @@tag_lost_handler = nil

    def initialize(serial_number=-1, timeout=0)
      super()
      create
      open(serial_number, timeout) if timeout > 0
    end

    private

    def create
      @@create = sym('CPhidgetRFID_create', 'Ip') if @@create == nil
      r,rs = @@create.call(@handle.ref)
      raise Phidgets::Exception.new(r) if r != 0
    end

    public

    def getOutputCount
      call_IPi(@@output_count, 'CPhidgetRFID_getOutputCount', @handle)
    end

    def getOutputState(index)
      call_IPIi(@@get_output_state, 'CPhidgetRFID_getOutputState', @handle, index)
    end

    def setOutputState(index, state)
      call_IXXX(@@set_output_state, 'CPhidgetRFID_setOutputState', 'IPII', @handle, index, state)
    end

    def getAntennaOn
      call_IPi(@@get_antenna_on, 'CPhidgetRFID_getAntennaOn', @handle)
    end

    def setAntennaOn(state)
      call_IPX(@@set_antenna_on, 'CPhidgetRFID_setAntennaOn', 'IPI', @handle, state)
    end

    def getLedOn
      call_IPi(@@get_led_on, 'CPhidgetRFID_getLEDOn', @handle)
    end

    def setLedOn(state)
      call_IPX(@@set_led_on, 'CPhidgetRFID_setLEDOn', 'IPI', @handle, state)
    end

    def getLastTag
      call_IPs(@@get_last_tag, 'CPhidgetRFID_getLastTag', @handle)
    end

    def getTagStatus
      call_IPi(@@get_tag_status, 'CPhidgetRFID_getTagStatus', @handle)
    end

    def setOnTagHandler(callback, data)
      call_IXXX(@@on_tag_handler, 'CPhidgetRFID_set_OnTag_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

    def setOnTagLostHandler(callback, data)
      call_IXXX(@@tag_lost_handler, 'CPhidgetRFID_set_OnTagLost_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

  end

end

