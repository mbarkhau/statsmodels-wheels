# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function build_wheel {
    # Prevent spurious numpy upgrade by using bdist_wheel
    wrap_wheel_builder build_pip_wheel $@
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    # Check OpenBLAS core
    export OPENBLAS_VERBOSE=2
    python -c 'import statsmodels.api as sm; sm.show_versions();'
    python -c 'import statsmodels; statsmodels.test(extra_args=["--skip-slow", "--skip-examples", "-n 2"], exit=True)'
}
