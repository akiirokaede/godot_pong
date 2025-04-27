extends AudioStreamPlayer

# 生成一个方波的音频流
func generate_square_wave(frequency: float, duration: float):
    var sample_rate = 44100
    var sample_count = int(sample_rate * duration)
    var data = PackedByteArray()
    
    for i in range(sample_count):
        var t = float(i) / sample_rate
        var value = 1.0 if fmod(t * frequency, 1.0) < 0.5 else -1.0
        var byte_value = int(clamp(value * 32767, -32768, 32767))
        data.append(byte_value & 0xFF)
        data.append((byte_value >> 8) & 0xFF)
    
    var audio_stream = AudioStreamWAV.new()
    audio_stream.mix_rate = sample_rate
    audio_stream.format = AudioStreamWAV.FORMAT_8_BITS
    audio_stream.data = data
    stream = audio_stream

func _ready():
    generate_square_wave(440.0, 0.1)

