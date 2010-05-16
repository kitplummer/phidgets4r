require File.dirname(__FILE__) + '/test_helper.rb'

class TestPhidgetsServo < Test::Unit::TestCase

  def setup
    sleep 1
  end

  def test_001_create
    assert_nothing_raised {
      servo = Phidgets::Servo.new
      servo.delete
    }
  end

  def test_002_attach
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.close
      servo.delete
    }
  end

  def test_003_fail_attach
    assert_raises (Phidgets::Exception) {
      servo = Phidgets::Servo.new(1, 2000)
      servo.delete
    }
  end

  def test_004_get_device_name
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceName
      servo.close
      servo.delete
    }
  end

  def test_005_get_serial_number
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getSerialNumber
      servo.close
      servo.delete
    }
  end

  def test_006_get_device_version
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceVersion
      servo.close
      servo.delete
    }
  end

  def test_007_get_device_status
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceStatus
      servo.close
      servo.delete
    }
  end

  def test_008_get_device_type
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceType
      servo.close
      servo.delete
    }
  end

  def test_009_get_device_label
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceLabel
      servo.close
      servo.delete
    }
  end

  def test_010_get_device_id
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      servo.getDeviceID
      servo.close
      servo.delete
    }
  end

  def test_011_get_device_class
    device_class = Phidgets::CLASS_NOTHING
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      device_class = servo.getDeviceClass
      servo.close
      servo.delete
    }
    assert device_class == Phidgets::CLASS_SERVO
  end

  def test_012_get_motor_count
    device_id = 0
    count = -1
    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      device_id = servo.getDeviceID
      count = servo.getMotorCount
      servo.close
      servo.delete
    }
    assert 1 == count
  end

  def test_013_positions
    device_id = 0
    position = -1.0
    max = -1
    min = -1
    engaged = -1

    assert_nothing_raised {
      servo = Phidgets::Servo.new(-1, 2000)
      puts "device_id: #{servo.getDeviceID}"
      puts "device_name: #{servo.getDeviceName}"
      puts "status: #{servo.getDeviceStatus}"
      max = servo.getPositionMax(0)
      min = servo.getPositionMin(0)
      puts "min: #{min} - max: #{max}"
      servo.setPosition(0, 10.0)
      sleep 3

      position = servo.getPosition(0)
      servo.close
      servo.delete
    }
    puts "position: #{position}"
    assert 0.0 == min
    assert 220.0 == max
    assert 10.0 == position
  end

end
