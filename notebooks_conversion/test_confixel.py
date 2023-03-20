# Notes:
#   Original location: `ConFixel/confixel/notebooks/`;
#   Need to add necessary arguments in `.vscode/launch.json`;

import os
import os.path as op
import sys

sys.path.append(os.path.join(os.path.dirname(
    os.path.dirname(os.path.abspath(__file__))), "confixel"))
from confixel.fixels import main   # noqa

main()   # calling confixel (mif -> hdf5)
