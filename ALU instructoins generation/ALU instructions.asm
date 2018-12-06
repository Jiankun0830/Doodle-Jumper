# Accelerate: reduce period by 1/1024 (just a magic number)
reg0 = tick_period >> NINE
reg0 = reg0 >> ONE
tick_period = tick_period - reg0

# Check input correctness
reg0 = input < ZERO
reg0 = reg0 & is_le
reg1 = input > ZERO
reg1 = reg1 & is_ge
input_correct = reg0 | reg1

# Generate question if needed
reg0 = doodle_pos == ZERO			# If Doodle is on the ground
reg1 = input != ZERO				# ..
reg0 = reg0 & reg1				# .. and there is input
reg1 = qn0 < ZERO				# ..
conditional = reg0 | reg1			# .. or there is no question yet
	# generate question
	reg0 = prng0 
	reg1 = prng1 
	reg2 = prng2 

	reg0 = reg0 & PRNG_MASK
	reg1 = reg1 & PRNG_MASK
	reg2 = reg2 & PRNG_MASK

	reg0 = reg0 * HUNDRED
	reg1 = reg1 * HUNDRED
	reg2 = reg2 * HUNDRED

	reg2 = reg2 >> NINE
	reg1 = reg1 >> NINE
	qn0 = reg0 >> NINE

	qn1 = reg1 >> ONE
	qn2 = reg2 >> ONE

	reg0 = qn2 + qn1
	is_le = reg0 <= qn0
	is_ge = reg0 >= qn0
conditional = ONE 	# restore conditional

# Shift terrain to the left by 1 cell
reg0 = terrain0r & SHIFT_MASK
reg0 = reg0 >> FIFTEEN
terrain0r = terrain0r << ONE
terrain0l = terrain0l << ONE
terrain0l = terrain0l | reg0

reg0 = terrain1r & SHIFT_MASK
reg0 = reg0 >> FIFTEEN
terrain1r = terrain1r << ONE
terrain1l = terrain1l << ONE
terrain1l = terrain1l | reg0

reg0 = terrain2r & SHIFT_MASK
reg0 = reg0 >> FIFTEEN
terrain2r = terrain2r << ONE
terrain2l = terrain2l << ONE
terrain2l = terrain2l | reg0

# Generate rightmost column of terrain
conditional = terrain_gen_counter < OBSTACLE_WIDTH	# if this position should be an obstacle
	# generate obstacle
	terrain0r = terrain0r | ONE
	terrain1r = terrain1r | ONE
	terrain2r = terrain2r | ONE
conditional = ONE 					# restore conditional
terrain_gen_counter = terrain_gen_counter + ONE			# increment counter
conditional = terrain_gen_counter == OBSTACLE_SEPARATION	# if counter has reached modulo cap
	# wrap back to 0
	terrain_gen_counter = ZERO 
conditional = ONE 					# restore conditional

# Update doodle state
reg1 = doodle_pos == ZERO
reg2 = doodle_pos == MAX_HEIGHT
conditional = reg1 & input_correct		# if on the ground and input is correct
	# start jumping
	doodle_dir = ONE
	doodle_pos = ONE
	# and increment the score
	score = score + ONE
conditional = reg2	# if reached the max height
	# start falling
	doodle_dir = ZERO - ONE
	doodle_pos = MAX_HEIGHT - ONE
conditional = reg1 | reg2
conditional = conditional ^ ONE		# if neither on the ground nor max height
	# move according to the direction
	doodle_pos = doodle_pos + doodle_dir
conditional = ONE 		# restore conditional register

# update doodle render
doodle5 = DOODLE_SPRITE5 << doodle_pos
doodle4 = DOODLE_SPRITE4 << doodle_pos
doodle3 = DOODLE_SPRITE3 << doodle_pos
doodle2 = DOODLE_SPRITE2 << doodle_pos
doodle1 = DOODLE_SPRITE1 << doodle_pos
doodle0 = DOODLE_SPRITE0 << doodle_pos

# Check for collision
reg0 = terrain0l & COLLISION_MASK
reg1 = doodle_pos < THREE
conditional = reg0 != ZERO		# if there's an obstacle in Doodle's columns
conditional = conditional & reg1	# .. and Doodle hasn't jumped high enough
	# game over
	game_running = ZERO 
conditional = ONE 		# restore condition

# Check if score has reached 99
reg0 = score + ONE
conditional = reg0 == HUNDRED		# if score+1 is 100
	# game over (win)
	game_running = ZERO 
conditional = ONE 		# restore conditional

