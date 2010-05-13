require File.dirname(__FILE__) + '/test_helper.rb'

class TestPhidgetsInterfaceKit < Test::Unit::TestCase

  def setup
    sleep 1
  end
  
  def test_001_create
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new
      ik.delete
    }
  end
  
  def test_002_attach
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.close
      ik.delete
    }
  end
  
  def test_003_fail_attach
    assert_raises (Phidgets::Exception) {
      ik = Phidgets::InterfaceKit.new(1, 2000)
      ik.delete
    }
  end
  
  def test_004_get_device_name
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceName
      ik.close
      ik.delete
    }
  end
  
  def test_005_get_serial_number
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getSerialNumber
      ik.close
      ik.delete
    }
  end
  
  def test_006_get_device_version
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceVersion
      ik.close
      ik.delete
    }
  end
  
  def test_007_get_device_status
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceStatus
      ik.close
      ik.delete
    }
  end
  
  def test_008_get_device_type
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceType
      ik.close
      ik.delete
    }
  end
  
  def test_009_get_device_label
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceLabel
      ik.close
      ik.delete
    }
  end
  
  def test_010_get_device_id
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      ik.getDeviceID
      ik.close
      ik.delete
    }
  end
  
  def test_011_get_device_class
    device_class = Phidgets::CLASS_NOTHING
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      device_class = ik.getDeviceClass
      ik.close
      ik.delete
    }
    assert device_class == Phidgets::CLASS_INTERFACEKIT
  end
  
  def test_012_get_input_count
    device_id = 0
    count = -1
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      device_id = ik.getDeviceID
      count = ik.getInputCount
      ik.close
      ik.delete
    }
    case device_id
      when Phidgets::ID_INTERFACEKIT_0_0_4
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_0_0_8
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_0_16_16
        assert count == 16
      when Phidgets::ID_INTERFACEKIT_8_8_8
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_8_8_8_w_LCD
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_0_8_8_w_LCD
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_4_8_8
        assert count == 8
      else
        flunk
    end
  end
  
  def test_013_get_output_count
    device_id = 0
    count = -1
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      device_id = ik.getDeviceID
      count = ik.getOutputCount
      ik.close
      ik.delete
    }
    case device_id
      when Phidgets::ID_INTERFACEKIT_0_0_4
        assert count == 4
      when Phidgets::ID_INTERFACEKIT_0_0_8
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_0_16_16
        assert count == 16
      when Phidgets::ID_INTERFACEKIT_8_8_8
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_8_8_8_w_LCD
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_0_8_8_w_LCD
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_4_8_8
        assert count == 8
      else
        flunk
    end
  end
  
  def test_014_get_sensor_count
    device_id = 0
    count = -1
    assert_nothing_raised {
      ik = Phidgets::InterfaceKit.new(-1, 2000)
      device_id = ik.getDeviceID
      count = ik.getSensorCount
      ik.close
      ik.delete
    }
    case device_id
      when Phidgets::ID_INTERFACEKIT_0_0_4
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_0_0_8
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_0_16_16
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_8_8_8
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_8_8_8_w_LCD
        assert count == 8
      when Phidgets::ID_INTERFACEKIT_0_8_8_w_LCD
        assert count == 0
      when Phidgets::ID_INTERFACEKIT_4_8_8
        assert count == 4
      else
        flunk
    end
  end
end
