
require 'dl'
require 'rbconfig'

module Phidgets

  NOTATTACHED                 = 0
  ATTACHED                    = 1

  CLASS_NOTHING               = 1
  CLASS_ACCELEROMETER         = 2
  CLASS_ADVANCEDSERVO         = 3
  CLASS_ENCODER               = 4
  CLASS_GPS                   = 5
  CLASS_GYROSCOPE             = 6
  CLASS_INTERFACEKIT          = 7
  CLASS_LED                   = 8
  CLASS_MOTORCONTROL          = 9
  CLASS_PHSENSOR              = 10
  CLASS_RFID                  = 11
  CLASS_SERVO                 = 12
  CLASS_STEPPER               = 13
  CLASS_TEMPERATURESENSOR     = 14 
  CLASS_TEXTLCD               = 15
  CLASS_TEXTLED               = 16
  CLASS_WEIGHTSENSOR          = 17

  ID_ACCELEROMETER_2AXIS      = 0x071
  ID_ACCELEROMETER_3AXIS      = 0x07E
  ID_ADVANCEDSERVO_8MOTOR     = 0x03A
  ID_BIPOLAR_STEPPER_1MOTOR   = 0x07B
  ID_ENCODER_1ENCODER_1INPUT  = 0x04B
  ID_ENCODER_HS_1ENCODER      = 0x080
  ID_INTERFACEKIT_0_0_4       = 0x040
  ID_INTERFACEKIT_0_0_8       = 0x081
  ID_INTERFACEKIT_0_16_16     = 0x044
  ID_INTERFACEKIT_8_8_8       = 0x045
  ID_INTERFACEKIT_8_8_8_w_LCD = 0x07D
  ID_LED_64                   = 0x04A
  ID_LINEAR_TOUCH             = 0x076
  ID_MOTORCONTROL_HC_2MOTOR   = 0x059
  ID_MOTORCONTROL_LV_2MOTOR_4INPUT = 0x058
  ID_PHSENSOR                 = 0x074
  ID_RFID_2OUTPUT             = 0x031
  ID_ROTARY_TOUCH             = 0x077
  ID_SERVO_1MOTOR             = 0x039
  ID_TEMPERATURESENSOR        = 0x070
  ID_TEXTLCD_2x20_w_8_8_8     = 0x17D
  ID_UNIPOLAR_STEPPER_4MOTOR  = 0x07A
  ID_INTERFACEKIT_0_8_8_w_LCD = 0x053
  ID_INTERFACEKIT_4_8_8       = 0x004
  ID_RFID                     = 0x030
  ID_SERVO_1MOTOR_OLD         = 0x002
  ID_SERVO_4MOTOR             = 0x038
  ID_SERVO_4MOTOR_OLD         = 0x003
  ID_TEXTLCD_2x20             = 0x052
  ID_TEXTLCD_2x20_w_0_8_8     = 0x153
  ID_TEXTLED_1x8              = 0x049
  ID_TEXTLED_4x8              = 0x048
  ID_WEIGHTSENSOR             = 0x072 

  def Phidgets.setLibName(name)
    Common.setLibName(name)
  end

  class Exception < RuntimeError
    attr_reader :code

    EPHIDGET_NOTFOUND    = 1
    EPHIDGET_NOMEMORY    = 2
    EPHIDGET_UNEXPECTED  = 3
    EPHIDGET_INVALIDARG  = 4
    EPHIDGET_NOTATTACHED = 5
    EPHIDGET_INTERRUPTED = 6
    EPHIDGET_INVALID     = 7
    EPHIDGET_NETWORK     = 8
    EPHIDGET_UNKNOWNVAL  = 9
    EPHIDGET_BADPASSWORD = 10
    EPHIDGET_UNSUPPORTED = 11
    EPHIDGET_DUPLICATE   = 12
    EPHIDGET_TIMEOUT     = 13
    EPHIDGET_OUTOFBOUNDS = 14
    EPHIDGET_EVENT       = 15
    EPHIDGET_NETWORK_NOTCONNECTED = 16
    EPHIDGET_WRONGDEVICE = 17
    EPHIDGET_CLOSED      = 18
    EPHIDGET_BADVERSION  = 19

    def initialize(code)
      @code = code
      case code
        when -2
          super('Failed to load Phidgets Library')
        when -1
          super('Unable to determine Phidgets Library name.')
        when EPHIDGET_NOTFOUND
          super('A Phidget matching the type and or serial number could not be found.')
        when EPHIDGET_NOMEMORY
          super('Memory could not be allocated.')
        when EPHIDGET_UNEXPECTED
          super('Unexpected Error. Contact Phidgets Inc. for support.')
        when EPHIDGET_INVALIDARG
          super('Invalid argument passed to function.')
        when EPHIDGET_NOTATTACHED
          super('Phidget not physically attached.')
        when EPHIDGET_INTERRUPTED
          super('Read/Write operation was interrupted.')
        when EPHIDGET_INVALID
          super('The Error Code is not defined.')
        when EPHIDGET_NETWORK
          super('Network Error.')
        when EPHIDGET_UNKNOWNVAL
          super('Value is Unknown (State not yet received from device, or not yet set by user).')
        when EPHIDGET_BADPASSWORD
          super('Authorization Failed.')
        when EPHIDGET_UNSUPPORTED
          super('Not Supported.')
        when EPHIDGET_DUPLICATE
          super('Duplicated request.')
        when EPHIDGET_TIMEOUT
          super('Given timeout has been exceeded.')
        when EPHIDGET_OUTOFBOUNDS
          super('Index out of Bounds.')
        when EPHIDGET_EVENT
          super('A non-null error code was returned from an event handler.')
        when EPHIDGET_NETWORK_NOTCONNECTED
          super('A connection to the server does not exist.')
        when EPHIDGET_WRONGDEVICE
          super('Function is not applicable for this device.')
        when EPHIDGET_CLOSED
          super('Phidget handle was closed.')
        when EPHIDGET_BADVERSION
          super('Webservice and Client protocol versions don’t match. Update to newest release.')
      end
    end

  end

  class Common
    @@libname = nil
    @@lib = nil
    @@open_remote = nil
    @@open_remote_ip = nil
    @@open = nil
    @@close = nil
    @@delete = nil
    @@detach_handler = nil
    @@attach_handler = nil
    @@connect_handler = nil
    @@disconnect_handler = nil
    @@error_handler = nil
    @@name = nil
    @@serial = nil
    @@version = nil
    @@status = nil
    @@lib_version = nil
    @@type = nil
    @@get_label = nil
    @@set_label = nil
    @@error_description = nil
    @@wait = nil
    @@server_id = nil
    @@server_addr = nil
    @@server_status = nil
    @@device_id = nil
    @@device_class = nil

    def initialize
      if @@libname == nil
        case Config::CONFIG['target_os']
          when 'linux'
            @@libname = 'libphidget21.so'
          when 'mswin32'
            @@libname = 'phidget21.dll'
          when 'darwin10.2.0'
            @@libname = '/Library/Frameworks/Phidget21.framework/Versions/Current/Phidget21'
          when 'darwin10.3.0'
            @@libname = '/Library/Frameworks/Phidget21.framework/Versions/Current/Phidget21'
          else
            raise Phidgets::Exception.new(-1)
        end
      end

      begin
        @@lib = DL.dlopen(@@libname)
      rescue
        raise Phidgets::Exception.new(-2)
      end

      @handle = DL.malloc(DL.sizeof('P'))
      
    end

    private

    def sym(name, interface)
      @@lib[name, interface]
    end

    def call_IX(sym_name, func_name, format, arg1)
      sym_name = sym(func_name, format) if sym_name == nil
      r,rs = sym_name.call(arg1)
      raise Phidgets::Exception.new(r) if r != 0
    end

    def call_IXX(sym_name, func_name, format, arg1, arg2)
      sym_name = sym(func_name, format) if sym_name == nil
      r,rs = sym_name.call(arg1, arg2)
      raise Phidgets::Exception.new(r) if r != 0
    end

    def call_IXXX(sym_name, func_name, format, arg1, arg2, arg3)
      sym_name = sym(func_name, format) if sym_name == nil
      r,rs = sym_name.call(arg1, arg2, arg3)
      raise Phidgets::Exception.new(r) if r != 0
    end

    def call_IXXXX(sym_name, func_name, format, arg1, arg2, arg3, arg4)
      sym_name = sym(func_name, format) if sym_name == nil
      r,rs = sym_name.call(arg1, arg2, arg3, arg4)
      raise Phidgets::Exception.new(r) if r != 0
    end

    def call_IXXXXX(sym_name, func_name, format, arg1, arg2, arg3, arg4, arg5)
      sym_name = sym(func_name, format) if sym_name == nil
      r,rs = sym_name.call(arg1, arg2, arg3, arg4, arg5)
      raise Phidgets::Exception.new(r) if r != 0
    end

    def call_IPi(sym_name, func_name, arg1)
      sym_name = sym(func_name, 'IPi') if sym_name == nil
      return_arg = 0
      r,rs = sym_name.call(arg1, return_arg)
      raise Phidgets::Exception.new(r) if r != 0
      rs[1]
    end

    def call_IPIi(sym_name, func_name, arg1, arg2)
      sym_name = sym(func_name, 'IPIi') if sym_name == nil
      return_arg = 0
      r,rs = sym_name.call(arg1, arg2, return_arg)
      raise Phidgets::Exception.new(r) if r != 0
      rs[2]
    end
    
    def call_IPId(sym_name, func_name, arg1, arg2)
      sym_name = sym(func_name, 'IPId') if sym_name == nil
      return_arg = 0.0
      r,rs = sym_name.call(arg1, arg2, return_arg)
      raise Phidgets::Exception.new(r) if r != 0.0
      rs[2]
    end

    def call_IPs(sym_name, func_name, arg1)
      sym_name = sym(func_name, 'IPp') if sym_name == nil
      arg_ptr = DL.malloc(DL.sizeof('P'))
      r,rs = sym_name.call(arg1, arg_ptr.ref)
      raise Phidgets::Exception.new(r) if r != 0
      arg_ptr.free = nil
      arg_ptr.to_s
    end

    def createCallback(callback)
      DL.callback('IPP') {|handle,data|
        data = ObjectSpace._id2ref(data.to_i)
        eval("#{callback}(data)")
      }
    end

    def createErrorCallback(callback)
      DL.callback('IPPIS') {|handle,data,error_code,error_string|
        data = ObjectSpace._id2ref(data.to_i)
        eval("#{callback}(data,error_code,error_string)")
      }
    end

    public

    def Common.setLibName(name)
      @@libname = name
    end

    def openRemote(serial_number=-1, server=nil, password=nil, timeout=0)
      call_IXXXX(@@open_remote, 'CPhidget_openRemote', 'IPISS', @handle, serial_number, server, password)
      waitForAttachment(timeout) if timeout > 0
    end

    def openRemoteIP(serial_number, address, port=5001, password=nil, timeout=0)
      call_IXXXXX(@@open_remote_ip, 'CPhidget_openRemoteIP', 'IPISIS', @handle, serial_number, address, port, password)
      waitForAttachment(timeout) if timeout > 0
    end

    def open(serial_number=-1, timeout=0)
      call_IXX(@@open, 'CPhidget_open', 'IPI', @handle, serial_number)
      waitForAttachment(timeout) if timeout > 0
    end

    def close
      call_IX(@@close, 'CPhidget_close', 'IP', @handle)
    end

    def delete
      @handle.free = nil
      call_IX(@@delete, 'CPhidget_delete', 'IP', @handle)
    end

    def setOnDetachHandler(callback, data)
      call_IXXX(@@detach_handler, 'CPhidget_set_OnDetach_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

    def setOnAttachHandler(callback, data)
      call_IXXX(@@attach_handler, 'CPhidget_set_OnAttach_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

    def setOnConnectHandler(callback, data)
      call_IXXX(@@connect_handler, 'CPhidget_set_OnServerConnect_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

    def setOnDisconnectHandler(callback, data)
      call_IXXX(@@disconnect_handler, 'CPhidget_set_OnServerDisconnect_Handler', 'IPPP', @handle, createCallback(callback), DL::PtrData.new(data.object_id))
    end

    def setOnErrorHandler(callback, data)
      call_IXXX(@@error_handler, 'CPhidget_set_OnError_Handler', 'IPPP', @handle, createErrorCallback(callback), DL::PtrData.new(data.object_id))
    end

    def getDeviceName
      call_IPs(@@name, 'CPhidget_getDeviceName', @handle)
    end

    def getSerialNumber
      call_IPi(@@serial, 'CPhidget_getSerialNumber', @handle)
    end

    def getDeviceVersion
      call_IPi(@@version, 'CPhidget_getDeviceVersion', @handle)
    end

    def getDeviceStatus
      call_IPi(@@status, 'CPhidget_getDeviceStatus', @handle)
    end

    def getLibraryVersion
      @@lib_version = sym('CPhidget_getLibraryVersion', 'Ip') if @@lib_version == nil
      lib_version_ptr = DL.malloc(DL.sizeof('P'))
      r,rs = @@lib_version.call(lib_version_ptr.ref)
      raise Phidgets::Exception.new(r) if r != 0
      lib_version_ptr.free = nil
      lib_version_ptr.to_s
    end

    def getDeviceType
      call_IPs(@@type, 'CPhidget_getDeviceType', @handle)
    end

    def getDeviceLabel
      call_IPs(@@get_label, 'CPhidget_getDeviceLabel', @handle)
    end

    def setDeviceLabel(label)
      call_IXX(@@set_label, 'CPhidget_setDeviceLabel', 'IPS', @handle, label)
    end

    def getErrorDescription(error_code)
      @@error_description = sym('CPhidget_getErrorDescription', 'IIp') if @@error_description == nil
      error_description_ptr = DL.malloc(DL.sizeof('P'))
      r,rs = @@error_description.call(error_code, error_description_ptr.ref)
      raise Phidgets::Exception.new(r) if r != 0
      error_description_ptr.free = nil
      error_description_ptr.to_s
    end

    def waitForAttachment(timeout)
      call_IXX(@@wait, 'CPhidget_waitForAttachment', 'IPI', @handle, timeout)
    end

    def getServerID
      call_IPs(@@server_id, 'CPhidget_getServerID', @handle)
    end

    def getServerAddress
      @@server_addr = sym('CPhidget_getServerAddress', 'IPpi') if @@server_addr == nil
      server_addr_ptr = DL.malloc(DL.sizeof('P'))
      server_port = 0
      r,rs = @@server_addr.call(@handle, server_addr_ptr.ref, server_port)
      raise Phidgets::Exception.new(r) if r != 0
      server_addr_ptr.free = nil
      a = [server_addr_ptr.to_s, rs[2]]
      a
    end

    def getServerStatus
      call_IPi(@@server_status, 'CPhidget_getServerStatus', @handle)
    end

    def getDeviceID
      call_IPi(@@device_id, 'CPhidget_getDeviceID', @handle)
    end

    def getDeviceClass
      call_IPi(@@device_class, 'CPhidget_getDeviceClass', @handle)
    end

  end

end

