Copyright © 2025 State Key Laboratory of Information Engineering in Surveying, Mapping and Remote Sensing, University of Wuhan.  
For questions, contact wangzhuoer@whu.edu.cn

# TCCBRN
This repository is the code of "TCCBRN: A Causal Convolutional Recurrent Network for Indirect Trajectory Prediction without its position information" on the HighD dataset. 

## License
The code is shared only for **research purposes**, and cannot be used for any commercial purposes.

Authors: Zhuoer Wang, Xiaowen Zhu, Yujia Wang, Zuo Huang, Jian Zhou, Haomiao Bian, and Bijun Li

## Abstract
Accurate short-term vehicle trajectory prediction is crucial for building intelligent transportation systems and facilitating decision-making in autonomous driving. While existing trajectory prediction methods assume that all vehicles are intelligent connected vehicles (ICVs) and utilize historical trajectory data to conduct predictions, their neglect of the mixed traffic conditions involving human-driven vehicles (HDVs), whose operation data are unavailable, often persists for the foreseeable future in real-world scenarios. When ICVs need to predict the trajectories of surrounding HDVs, they cannot use the HDVs’ historical position information due to the lack of intelligent connected devices and can only use their own trajectories for indirect prediction. To address this, we propose a Temporal Causal Convolutional Bidirectional Recurrent Network (TCCBRN), a model combining causal convolution layers and recurrent neural networks. The graph-based causal convolution layer is used for processing trajectory data and extracting spatial interaction features, and the recurrent neural layer achieves indirect predictions based on these features. This network indirectly predicts the trajectories of surrounding HDVs by leveraging the trajectories of ICVs. Additionally, we introduce an Improved Dung Beetle Optimization (IDBO) algorithm to optimize the high-dimensional hyperparameters of TCCBRN. By introducing piecewise chaotic mapping and dynamic weight coefficients to enhance the population generation and updating mechanisms, IDBO increases both the optimization dimension and search efficiency, making it well-suited for hyperparameter optimization in multi-agent surrounded prediction tasks. Experiments using the HighD and Shanghai Beiheng Passageway datasets show that our method outperforms state-of-the-art approaches in predicting HDV trajectories based on surrounding ICV data, which further meets practical application requirements.

## Acknowledgment
This research was supported by the State Key Program of National Natural Science Foun dation of China (52332010). The numerical calculations in this article have been done on the supercomputing system in the Supercomputing Center of Wuhan University. The authors also acknowledge all editors and reviewers for their suggestions.




