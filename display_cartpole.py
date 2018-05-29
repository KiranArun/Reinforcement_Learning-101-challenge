import os,time,sys
import numpy as np
import gym
import keras

nn = keras.models.load_model('/content/models/nn.hdf5')

if len(sys.argv) > 1:
    repeats = int(sys.argv[1])
else:
    repeats = 1

env = gym.make('CartPole-v1')

history = np.empty([0])

for i in range(repeats):
    d = False
    s = env.reset()

    tot_reward = 0

    while d == False:

      a = np.argmax(nn.predict(s.reshape(1,1,4)))
      
      s,r,d,_ = env.step(a)
      env.render()
      tot_reward += r

      time.sleep(0.02)
      
    print('run', i, 'reward =', tot_reward)
    history = np.append(history,tot_reward)

print('mean reward =', np.mean(history))