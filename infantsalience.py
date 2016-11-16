"""
@author: Anne S. Warlaumont

To use this module, you will need to install the MATLAB Engine API for Python:

http://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html

Afterward, if using anaconda on Mac like me, you will have to run the
following each time you start a shell before opening ipython or running
a python script:

export DYLD_LIBRARY_PATH=/System/Library/Frameworks/Python.framework/Versions/2.7/lib:$DYLD_LIBRARY_PATH

Then in python run the following to start MATLAB:
engine = matlab.engine.start_matlab()
and pass engine to get_model_info

Reference: https://www.mathworks.com/matlabcentral/answers/203592-matlab-engine-for-python-segfaults-in-matlab-engine-start_matlab-matlab-r2014b-os-x?s_tid=answers_rc1-2_p2

"""

"""
TO DO:

Use getAllSalienceOnsets.m and infantsphinx.py for examples

(in progress) Have get_model_info also save a text file with the full cortical filter activation data.

postlena.py can then import this module and run these for each wav file in
a list, as it does to get the Sphinx data

"""

class ModelInfo:
    'Salience peaks and cortical filter summed over time'
    
    def __init__(self, num_salience_peaks, num_timebins, filter_sums):
        self.num_salience_peaks = num_salience_peaks
        self.num_timebins = num_timebins
        self.filter_sums = filter_sums

def get_model_info(wavfile, engine, cortResp_outfilename):
    
    """Run Coath & Denham's auditory saliency model on the utterance wav file.
    
    Return a ModelInfo object containing:
    - the number of salience peaks
    - the number of timebins
    - the total activation of each cortical filter, summed over timebins.
    
    Additionally, save a csv file (named cortResp_outfilename) containing
    a matrix with all the cortical filter activations at each time bin
    (i.e. not collapsing over time).
    
    Coath & Denham's model is in MATLAB.
    This function calls MATLAB using the MATLAB Engine API for Python."""
    
    salinfo = engine.auditoryPerceptualOnsets(wavfile,.3,1,0)
    num_salience_peaks = salinfo['pOnsets'].size[0]
    num_timebins = salinfo['saliency'].size[1]
    filter_sums = engine.sum(salinfo['cortResp'],2)._data
    model_info = ModelInfo(num_salience_peaks, num_timebins, filter_sums)
    engine.dlmwrite(cortResp_outfilename, salinfo['cortResp'], nargout=0)
    return model_info