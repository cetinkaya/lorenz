-- Ahmet Cetinkaya, 2015

function iterate(params, state, dt)
   local new_state = {}
   new_state.x = state.x + params.sigma * (state.y - state.x) * dt
   new_state.y = state.y + (state.x * (params.rho - state.z) - state.y) * dt
   new_state.z = state.z + (state.x * state.y - params.beta * state.z) * dt
   return new_state
end

function love.load()
   test_params = {}
   test_params.sigma = 10
   test_params.beta = 8 / 3
   test_params.rho = 28

   initial_state = {x=10, y=0, z=0}
   lorenz_state = initial_state
   all_states = {}
   i = 1
   maxi = 300

   love.graphics.setLineStyle("smooth")
   love.graphics.setColor(200, 100, 120)
end

function love.update(dt)
   lorenz_state = iterate(test_params, lorenz_state, dt)
   all_states[i] = lorenz_state
   i = i + 1
   if i > maxi then
      i = 1
   end
end

function love.draw()
   for j = 1, table.getn(all_states) do
      local k = j - 1
      if k == 0 then
         k = table.getn(all_states)
      end
      
      local x1 = 400 + 7 * all_states[k].x
      local y1 = 300 + 7 * all_states[k].y
      local x2 = 400 + 7 * all_states[j].x
      local y2 = 300 + 7 * all_states[j].y

      if (k ~= i - 1 and j ~= i) then
         love.graphics.line(x1, y1, x2, y2)
      end
   end
end
