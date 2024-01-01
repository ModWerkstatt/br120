local bbs2util = require "bbs2util"

function data()
return {
	tracks = {
		{ name = "vehicle/anfahrt.wav", refDist = 25.0 },
		{ name = "vehicle/Lueftung.wav", refDist = 25.0 },
		{ name = "vehicle/stand.wav", refDist = 25.0 },
		{ name = "vehicle/kurve.wav", refDist = 25.0 },
		{ name = "vehicle/train/brakes.wav", refDist = 25.0 },
	},
	events = {
		horn = { names = { "vehicle/einheitsloks/br110_horn.wav" }, refDist = 16.0 },
	},
	updateFn = function (input)
		return {
			tracks = {
			-- anfahrt
				{
				  gain = bbs2util.sampleCurve({
							{0.0, 0.0 },
							{0.09, 0.0 },
							{0.1, 0.7 },
							{0.3, 0.9 },
							{0.4, 0.7 },
							{0.6, 0.4 },
							{1.0, 0.0 },
						 }, input.speed01),
				  pitch = bbs2util.sampleCurve({
							{0.0, 0.9 },
							{0.34, 0.9 },
							{1.0, 0.9 },
						  }, input.speed01)
				},
			-- Lueftung
				{ gain = bbs2util.sampleCurve({
							{0.0, 0.0 },
							{0.01, 0.9 },
							{0.33, 1.0 },
							{1.0, 1.1 },
						 }, input.speed01),
				  pitch = bbs2util.sampleCurve({
							{0.0, 0.9 },
							{0.15, 1.0 },
							{1.0, 1.0 },
						  }, input.speed01)
				},
			-- stand
				{
				  gain = bbs2util.sampleCurve({
							{0.0, 1.0 },
							{0.01, 0.1 },
							{0.25, 0 },
							{1.0, 0 },
						 }, input.speed01),
				  pitch = bbs2util.sampleCurve({
							{0.0, 0.7 },
							{1.0, 0.7 },
						  }, input.speed01)
				},
			    bbs2util.squeal(input.speed, input.sideForce, input.maxSideForce),
				bbs2util.brake(input.speed, input.brakeDecel, 0.5),
			},
			events = {
				horn = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
	}
end
